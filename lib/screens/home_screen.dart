import 'package:FSSP_cilent/screens/building_screen.dart';
import 'package:flutter/material.dart';
import 'package:FSSP_cilent/models/review_model.dart';
import 'package:FSSP_cilent/services/api_service.dart';
import 'package:FSSP_cilent/widgets/review_widget.dart';
import 'package:remedi_kopo/remedi_kopo.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<ReviewModel>> reviews = ApiService.getLatestReviews();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.house_rounded,
              color: Colors.blue.shade300,
              size: 40,
            ),
            const Text(
              "집사",
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          SearchBar(
            trailing: const [Icon(Icons.search)],
            hintText: "주소를 검색해주세요.",
            onTap: () async {
              KopoModel? model = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RemediKopo(),
                ),
              );
              if (model != null) {
                String? address = model.address;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BuildingScreen(address: address!),
                  ),
                );
              }
            },
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            "#원룸 #오피스텔 #아파트",
          ),
          const Text(
            "최신 리뷰",
          ),
          Expanded(
            child: FutureBuilder<List<ReviewModel>>(
              future: reviews,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (snapshot.hasData) {
                  return makeList(snapshot);
                } else {
                  return const Center(
                    child: Text('No reviews available'),
                  );
                }
              },
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const Text("#수원시 #영통구"),
          const Text("관심 지역 리뷰"),
          Expanded(
            child: FutureBuilder<List<ReviewModel>>(
              future: reviews,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (snapshot.hasData) {
                  return makeList(snapshot);
                } else {
                  return const Center(
                    child: Text('No reviews available'),
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 여기에 버튼을 눌렀을 때 수행할 작업을 정의합니다.
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.edit),
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<ReviewModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      itemBuilder: (context, index) {
        var review = snapshot.data![index];
        return Review(
          id: review.id,
          address: review.address,
          advantage: review.advantage,
          disadvantage: review.disadvantage,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        width: 40,
      ),
    );
  }
}
