import '../data/my_data.dart';
import '../data/public_data.dart';
import '../model/data/data_class.dart';

// 내 랭킹 정보를 가져오는 함수
void setMyRank(MyDataController myDataController, PublicDataController publicDataController) {
  final totalRankList = publicDataController.rankingMap['전체']!;
  final fandomRankList = publicDataController.rankingMap[myDataController.myChoicechannel.value]!;
  final myUid = myDataController.myUid.value;
  // 전체 랭킹 리스트에서 rank 가져오기
  int? totalRank = getRank(totalRankList, myUid);
  myDataController.myRank.value = totalRank ?? 0;
  // 팬덤 랭킹 리스트에서 rank 가져오기
  int? fandomRank = getRank(fandomRankList, myUid);
  myDataController.myFandomRank.value = fandomRank ?? 0;
}

// 내 랭킹 정보를 랭킹 리스트에서 찾는 함수
int? getRank(List<RankingDataClass> rankList, String myUid) {
  return rankList
      .firstWhere(
        (item) => item.uid == myUid,
        orElse: () => RankingDataClass('', '', '', 0, 0, 0),
      )
      .rank;
}
