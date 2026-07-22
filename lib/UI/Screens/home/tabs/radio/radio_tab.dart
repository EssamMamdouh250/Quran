import 'package:flutter/material.dart';
import 'package:quran/UI/Screens/home/tabs/radio/model/RadioModel.dart';
import 'package:quran/UI/Screens/home/tabs/radio/model/RecitersModel.dart';
import 'package:quran/UI/Screens/home/tabs/radio/network/api_service.dart';
import 'package:quran/UI/Screens/utilites/AssetsManeger.dart';
import 'package:quran/UI/Screens/utilites/appColors.dart';
import 'package:audioplayers/audioplayers.dart';

class RadioTab extends StatefulWidget {
  const RadioTab({super.key});

  @override
  State<RadioTab> createState() => _RadioTabState();
}

class _RadioTabState extends State<RadioTab> {
  List<RadioModel> radioList = [];
  List<ReciterModel> reciterList = [];
  bool isLoadingRadios = true;
  bool isLoadingReciters = true;

  int selectedTabIndex = 0;

  final AudioPlayer _audioPlayer = AudioPlayer();
  String? currentlyPlayingUrl;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    loadRadios();
    loadReciters();
  }

  void loadRadios() async {
    var data = await ApiService.fetchRadios();
    if (!mounted) return;
    setState(() {
      radioList = data;
      isLoadingRadios = false;
    });
  }

  void loadReciters() async {
    var data = await ApiService.fetchReciters();
    if (!mounted) return;
    setState(() {
      reciterList = data;
      isLoadingReciters = false;
    });
  }

  void _togglePlay(String url) async {
    if (currentlyPlayingUrl == url && isPlaying) {
      await _audioPlayer.pause();
      setState(() {
        isPlaying = false;
      });
    } else {
      await _audioPlayer.stop();
      await _audioPlayer.play(UrlSource(url));
      setState(() {
        currentlyPlayingUrl = url;
        isPlaying = true;
      });
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Widget _buildTabButton(String title, int index) {
    final bool isActive = selectedTabIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (selectedTabIndex == index) return;
          setState(() {
            selectedTabIndex = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isActive
                ? AppColors.primary
                : AppColors.primary.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isActive ? AppColors.black : Colors.white60,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildCard({required String title, required String url}) {
    final bool isCurrentActive = currentlyPlayingUrl == url && isPlaying;

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                iconSize: 40,
                icon: Icon(
                  isCurrentActive
                      ? Icons.pause_rounded
                      : Icons.play_arrow_rounded,
                  color: AppColors.black,
                ),
                onPressed: () => _togglePlay(url),
              ),
              const SizedBox(width: 15),
              Icon(
                isCurrentActive
                    ? Icons.volume_up_rounded
                    : Icons.volume_off_rounded,
                color: AppColors.black,
                size: 26,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRadioList() {
    if (isLoadingRadios) {
      return const Center(
          child: CircularProgressIndicator(color: AppColors.primary));
    }
    if (radioList.isEmpty) {
      return const Center(
        child: Text(
          "لا توجد إذاعات متاحة حالياً",
          style: TextStyle(color: Colors.white),
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: radioList.length,
      itemBuilder: (context, index) {
        final radio = radioList[index];
        return _buildCard(title: radio.name, url: radio.url);
      },
    );
  }

  Widget _buildRecitersList() {
    if (isLoadingReciters) {
      return const Center(
          child: CircularProgressIndicator(color: AppColors.primary));
    }
    if (reciterList.isEmpty) {
      return const Center(
        child: Text(
          "لا توجد قراءات متاحة حالياً",
          style: TextStyle(color: Colors.white),
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: reciterList.length,
      itemBuilder: (context, index) {
        final reciter = reciterList[index];
        // `moshaf.server` from the API is just a folder (e.g.
        // "https://server6.mp3quran.net/akdr/"), not a playable file.
        // You have to append a zero-padded surah number + ".mp3" to get
        // an actual audio URL. We default to Surah Al-Fatiha (001).
        final String? baseServer = reciter.moshafList.isNotEmpty
            ? reciter.moshafList.first.server
            : null;

        if (baseServer == null || baseServer.isEmpty) {
          return const SizedBox.shrink();
        }

        final String normalizedBase =
            baseServer.endsWith('/') ? baseServer : '$baseServer/';
        final String url = '${normalizedBase}001.mp3';

        return _buildCard(title: reciter.name, url: url);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 10),
              Image.asset(
                AssetsManager.ImgLogo,
                width: 250,
                height: 170,
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    _buildTabButton("Radio", 0),
                    const SizedBox(width: 10),
                    _buildTabButton("Reciters", 1),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: selectedTabIndex == 0
                    ? _buildRadioList()
                    : _buildRecitersList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}