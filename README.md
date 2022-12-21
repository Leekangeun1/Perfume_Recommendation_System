# App Download Link
https://drive.google.com/file/d/1mEs5q6IhmaItt2oLWxI1aAiBMYVjgs1H/view?usp=sharing

--------------------------------

## Perfume Recommendation System

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

----------------------------

## Presentation Scripts

1. (제목)
 안녕하십니까, 이번 프로젝트로 향수 추천 시스템을 만든 이강은이라고 합니다. 

2. (팀 멤버)
 팀 멤버는 저 혼자이고요, 혼자 진행하는 프로젝트이다보니, 역할 분담은 따로 없이 data collection, data storing, ui design, implementation을 혼자 진행하였습니다. 

3. (주제는 향수)
 향수는 우리 삶에서 매우 중요한 역할을 합니다. 우리의 매력이나 정체성을 표현하고 나라는 사람의 identity를 확립하는 데에 있어 향수는 매우 큰 역할을 합니다. 인간의 후각이 오감 중에서 가장 민감한 감각이라는 말이 있듯이, 대인 관계에 있어서도 사람에게서 느껴지는 향기는 그 사람의 첫인상을 결정하는 데에 굉장히 큰 역할을 합니다. 그래서 일반적으로 향수에 관심을 가지고 계신 분들이 많을 텐데요, 이러한 상황에서 문제점들이 몇 가지 발생합니다. 향수를 사러 매장에 가보게 되면, 아무거나 살 수는 없으니 여러 향수들의 향을 맡아보고 테스트해본 뒤에 구매하게 되는데요, 문제는 이런 향수들이 너무나 많고 다양하다는 것입니다. 브랜드별로 향수 모델의 개수는 수백 개에서 수천 개까지 매우 많습니다. 이 많은 걸 다 시향해본 뒤에 구매하는 건 불가능할 겁니다. 또한 더 큰 문제점은, 우리의 코는 자극에 대해서 쉽게 피로를 느낀다는 점입니다. 후각신경은 민감한 만큼 쉽게 피로를 느껴서, 향을 몇 번 맡아보게 되면, 처음과는 달리 그 향이 그 향 같고, 어떤 게 더 좋은 향인지 구분하는 게 매우 힘들어집니다. 그래서 저는 향수를 추천해주는 시스템을 만들어 보기로 하였습니다. 

4. (data collection: kaggle)
 향수를 효과적으로 추천해주기 위해서는, 정형화된 향수의 리스트들이 필요합니다. 그래서 저는 Kaggle이라는 사이트로부터 open data set을 얻어왔습니다. 향수들의 모델과 브랜드, 그리고 가지고 있는 향들을 정리해 둔 data set이었습니다. 하지만 이 데이터들만 가지고는 향수를 구체화하여 정리하기 어렵다고 생각했습니다. 이를테면 향수가 가진 향들을 더 구조화해서 표현하고, 어울리는 계절이나 분위기 등도 있으면 좋겠다고 생각했습니다. 

5. (data collection: basenotes)
 그래서 방금 말씀드렸던 data set과 더불어 data collection을 한 번 더 진행하기로 했습니다. 이 향수 정보 사이트에서는 향수 모델을 검색하면 그 향수에 대한 정보를 보여줍니다. 이 사이트에서는 향수의 이름, 브랜드, 출시 일자.......
(Enter) - 향수 세부적인 모습
그리고 향들의 배합을 보여줍니다. 이를테면 지금 보여드리는 향수는 샤넬에서 2010년에 출시한 ‘블루드 샤넬 오드 뚜왈렛’이라는 향수입니다. 이 향수는 시트러스, 페퍼민트, 자스민 등등의 향을 포함하고 있습니다. 그래서 이 사이트에 대해서 웹 크롤링을 진행했습니다. 이전에 Kaggle에서 가져온 향수 이름을 검색해서 나온 결과 사이트에서 데이터를 추출하고, 구조를 다듬었습니다.
(Enter) - json 형태 모습
그래서 지금 보시는 바와 같이 향수 하나에 대해서 데이터가 이렇게 정리된 모습을 보실 수 있습니다. json format에 맞게 향수 데이터들을 정리했고요, 제일 위쪽부터 primary key입니다. 향수들을 구분할 ID들이고요, 그 밑에 fields의 하위 컬렉션으로 이름, 출시일자, 썸네일, 성별, 노트들, 어울리는 계절, 구매 가능 여부, 브랜드, 카테고리, 가격 순으로 정리해 두었습니다. 노트 부분을 보시면 top, heart, base로 나뉘어져 있는 걸 보실 수 있는데요, 간단하게만 설명해드리자면, top 노트는 향수를 뿌린 직후부터 알코올이 증발하기까지 약 10분 동안 맡을 수 있는 향입니다. heart 노트는 그 이후부터 약 3시간동안 맡을 수 있는 핵심적인 향이고요, base 노트는 향수를 뿌린 후 3시간 뒤부터 은은하게 맡을 수 있는 향입니다. 이렇게 3가지 향을 구획별로 정리해 두었습니다. 

6. (data collection: firebase)
 그래서 결과적으로 모은 향수 모델이 약 40000개 정도 됩니다. 향수들의 모델뿐만 아니라 데이터를 원활하게 관리하기 위해 향수들의 브랜드나 노트, 카테고리, 시즌 같은 데이터들도 따로 정의해서 저장해 두었습니다. 이렇게 해서 모든 데이터들을 모아서 json 형태로 저장했더니 약 140만줄 정도의 분량이 나왔습니다. 그리고 이 많고 많은 데이터들을 넣어두고 관리할 곳이 필요했는데요, 그 역할을 한 database server가 firebase입니다. 그래서 firebase에서 인식할 수 있는 형태로 json 형태를 다듬어준 뒤에

7. (data collection: firebase - 그림)
이렇게 firebase에 data set을 등록해 주었습니다. 
(Enter) - firebase2
그래서 아까 말씀드렸던 perfume의 정보가 모두 알맞게 들어간 모습을 보실 수 있습니다. 

8. (Recommendation Method)
 그럼 이 프로젝트의 추천 방법을 말씀드리겠습니다. 향수의 데이터가 40000개로 매우 많고, 리뷰는 그에 반해 매우 적은 편이어서, contents based filtering 방법을 사용하기로 했습니다. 사용자가 한 향수를 선택하면, 그 향수와 관련있는 다른 향수 모델들을 함께 추천해주는 방식입니다. 

9. (Cosine Similarity)
 그래서 이 향수를 추천해주는 알고리즘으로는 cosine similarity 방식을 사용하였습니다. 오른쪽에 보시는 모습이 이를 코드로 구현한 내용입니다. 이를 조금 더 자세히 살펴보도록 하겠습니다. 
(Enter) - Caculation Equations
두 개의 향수 모델 1, 2가 있다고 생각해보겠습니다. 모델 1은 오직 3번째 카테고리만 가지고 있고, 모델 2는 2번째와 3번째 카테고리를 동시에 가지고 있습니다. 포함 되었음과 포함되지 않았음을 표현하기 위해서 binary하게 0과 1만 사용하였습니다. 그래서 모델 1과 2의 길이는 피타고라스로 구했고요, 두 모델을 여기 예시에서는 5차원 벡터라고 가정하고 좌표처럼 내적값을 구했습니다. 이렇게 해서 내적의 정의를 이용해서 cosine 값을 구했고, 최종적으로 산출된 값이 cosine similarity가 됩니다. 

10. (Model1 and Model2)
 방금은 카테고리로만 예시를 들었지만, 두 모델을 비교할 척도는 카테고리 뿐만이 아닐 겁니다. 예를 들면 노트가 있을 겁니다. 이 노트의 경우에는 연관성을 계산하기가 어려웠는데요, 노트가 3가지 계층으로 나뉘어져 있는데, 같은 노트가 같은 계층에 대응하는 경우도 있었고, 다른 계층으로 대응하는 경우도 있었습니다. 그래서 직접 대응하는 경우는 direct hit, 간접적으로 대응하는 경우는 indirect hit으로 구분해서 계산했습니다. 두 hit의 가중치는 서로 다르게 설정해서 direct hit일 때 더 많은 점수를 얻게끔 하였습니다. 

11. Season:4
 그래서 두 향수 간에 비교하게 되는 척도들을 살펴보게 되면, 첫째로 season이 있습니다. season은 4가지로 분류되어 있기 때문에, 점수를 얻게 되는 기댓값이 상대적으로 크게 설정됩니다. 
(Enter) - category
그리고 category가 있는데, 12개의 category가 있기 때문에 기댓값이 아까보다는 상대적으로 낮습니다. 
(enter) - note
그리고 마지막으로 향의 성분을 나타내는 노트는 총 973가지가 있습니다. 그래서 점수의 기댓값이 매우 낮아집니다. 이 노트는 아까 말씀드렸다시피 
(enter) - direct, indirect
direct hit와 indirect hit가 있기 때문에
(enter) - 코드그림
두 가중치에 차이를 두어서 오른쪽의 그림과 같이 가중치를 정의하여 넣어주었습니다. 

12. Weights
기댓값의 비율에 맞춰서 season과 category는 그 경우의 수만큼 곱해주었고, note에 대해서는 여러 테스트를 거친 결과 가장 적절하다고 판단되는 가중치로 각각 30과 15를 넣어주었습니다. note의 가중치가 너무 크게 되면, season과 category는 무시되게 되고, 너무 작으면 note가 무시되어, 가장 합리적으로 결과를 도출하게끔 가중치를 보시는 바와 같이 설정해 두었습니다.

13. AP@K
다음은 evaluation입니다. 추천 시스템의 평가는 mean average precision @K를 이용해서 만들었고요, 오른쪽에 보시는 코드는 Mean average Precision을 만들기 전 과정인 Average Precision 부분입니다. Mean Average Precision은, 수많은 사용자들이 Average Precision을 평가한 뒤에, 그 평균을 내는 것이기 때문에, 우선 Average Precision을 계산해서 등록하는 코드를 넣어줬습니다.
(enter)
Average precision을 계산하는 방법은 위에 보시는 식을 보시면 됩니다. 어플리케이션을 실행하면, 추천 리스트를 1등부터 10등까지 나타내서 보여드리게 될 겁니다. 사용자는 해당 추천 리스트가 잘 추천 되었는지 그 결과의 만족도를 위의 식을 이용해서 보여주게 될 것입니다. 1등부터 10등까지의 리스트를 보게 된다면 10등보다는 1등의 정확성이 더 중요하지 않습니까? 그래서 1등의 가중치가 제일 높고, 10등의 가중치가 제일 낮게 되는 방법인 이 AP 방법을 사용하였습니다. 한가지 예시로는 1등부터 4등까지만 간략하게 보여드리겠습니다. 사용자가 이 앱을 평가할 때, 1등과 3등은 만족스럽지만 2등과 4등은 만족스럽지 못했다고 하면, 보시는 테이블처럼 평가표가 정리됩니다. Precision i와 relation i의 곱은 보시는 바와 같이 나타납니다. (왼쪽에서부터 1개, 2개, 3개, 4개 순으로 설명한다.)

* m = 사용자가 좋아한 아이템 개수. 7개 선택했으면 7.
* k = precision의 개수. 여기선 precision을 총 4번 했으니까 precision은 4.
* P(i) = 1~i번째 인덱스 중에서 사용자가 좋아한 아이템의 비율
* rel(i) = 해당 인덱스를 사용자가 좋아했는지 여부. 1과 0으로 이루어짐.

14. MAP@K
아까 말씀드렸던 방식으로 계산되었던 사용자들의 Average precision은 데이터베이스에 추가적으로 등록됩니다. MAP@K를 계산하기 위해서는, 저장된 DB에 접근해서 누적된 Average Precision을 다 더해서 평균을 구해줍니다. 이러한 방식으로 MAP@K를 구하는 알고리즘을 구현하였습니다.

15. Implementaion
이제 프로젝트를 구현한 내용에 대해서 말씀드린 뒤에, 데모까지 이어서 진행하겠습니다. 처음에 말씀드렸던 kaggle과 basenote website crawling을 이용해서 정규화된 데이터를 얻었고, 이를 json 형태로 정리하였습니다. 이 DB는 firebase에 저장하였습니다. 그리고 이 서버와 연동된 플러터를 이용해서 안드로이드 앱 개발을 진행했습니다. Recommendation과 Evaluation은 이 flutter 상에서 구현되어 있습니다. 그렇게 해서 안드로이드 APK 파일을 생성했고, 그 시연 영상을 이제 확인해보겠습니다.

16. Demo
데모 영상을 보시기 전에, 소스코드는 깃헙에 public으로 올려놨고, 아래 있는 링크는 APK를 다운받아서 사용해보실 수 있는 다운로드 링크입니다. 깃헙에 링크를 올려놨으니, 깃헙에서 다운받으실 수도 있겠습니다. 그럼 데모 영상을 보여드리겠습니다.

17. Lean Canvas
(제일 왼쪽) problem
고객들이 본인이 좋아하는 향수를 효율적으로 고르기 힘들다라는 문제점이 있었고, 현재로서는 이를 해결하는 방법은 그저 판매자가 주관적으로 추천해준 향수들을 고르거나, 직접 다 맡아보는 수밖에 없습니다.
(제일 오른쪽) customer
그래서 이 프로젝트는 이러한 소비자들이 될 것입니다. 20대부터 50대, 혹은 그 이상까지 전연령이 이 프로젝트의 대상이 됩니다.
(가운데) value
그래서 이러한 소비자들에게 제안하는 이 프로젝트의 가치는, 더이상 향수를 고르기 위해 후각을 혹사시키지 않아도 된다는 점입니다. 
(두번째 위) solution
이 추천 시스템은 고객이 좋아할만한 향수를 충분히 제공해줄 수 있을 것입니다.
(두번째 아래) key matrics
이 향수는 모든 고객, 어떤 고객에게도 적용될 수 있는 서비스이고, 시중에 이와 같은 서비스를 제공해주는 서비스는 없기 때문에 충분히 가치있는 서비스라고 생각합니다. 

18. Schedule
프로젝트를 진행하면서 11월동안은 구체적인 계획을 수립하고 데이터를 모아서 구조화하고 분류하는 데에 주력했습니다. 그리고 12월달부터 프론트엔드에서의 개발을 시작했는데요, 간단한 UI 위에서 주요 기능을 먼저 구현한 뒤에, 남은 기간동안 알고리즘을 개선시키고 UI를 구체화하여 디자인했습니다. 그렇게 해서 이와 같은 프로젝트를 완성할 수 있었습니다.

19. End
발표 들어주셔서 감사합니당


--------------------
## Scripts in English

1. (Title)
 Hello, I'm Lee Kang-eun, who created a perfume recommendation system with this project. 

2. (Team member)
 I'm the only member of the team, and since it's a project that I'm working on alone, I did data collection, data storage, Ui design, and implementation alone without any division of roles. 

3. (The topic is perfume)
 Perfume plays a very important role in our lives. Perfume plays a very big role in expressing our charm or identity and establishing the identity of me. As it is said that human sense of smell is the most sensitive of the five senses, the scent felt by a person in interpersonal relationships plays a very big role in determining the person's first impression. So in general, there are many people who are interested in perfumes, and there are some problems in this situation. If you go to the store to buy perfume, you can't buy anything, so you can smell and test the scents of various perfumes before you buy it, and the problem is that there are so many and so many different perfumes. The number of perfume models by brand is very high, ranging from hundreds to thousands. It would be impossible to buy it after re-scenting this much. Also, the bigger problem is that our noses easily feel tired from stimulation. The olfactory nerve feels tired easily as it is sensitive, so if you smell it a few times, the scent is like that, unlike the first time, and it is very difficult to tell which one is better. So I decided to make a system that recommends perfume. 

4. (data collection: kaggle)
 To recommend perfumes effectively, you need a list of standardized perfumes. So I got an open data set from a site called Kaggle. It was a data set that summarized the models, brands, and scents of perfumes. However, I thought it was difficult to organize perfumes by specifying them with only with these data. For example, I thought it would be nice to have a better season or atmosphere to express the scents of perfume in a more structured way. 

5. (data collection: basenotes)
 So we decided to proceed with the data collection one more time with the data set that I just mentioned. This perfume information site shows information about perfume when you search for a perfume model. On this site, the name, brand, and release date of the perfume...
(Enter) - Perfume details
And it shows the combination of scents. For example, the perfume I'm showing you now is "Blood Chanel Odd Tuwallet," which was released in 2010 by Chanel. This perfume contains scents such as citrus, peppermint, jasmine, etc. So we did web crawling on this site. I searched for perfume names from Kaggle previously, extracted data from the results site, and refined the structure.
(Enter) - json shape
So, as you can see, you can see how the data for one perfume is organized. I organized the perfume data according to the json format, and it is the primary key from the top. These are the IDs to distinguish perfumes, and below them are the sub-collection of fields in order of name, release date, thumbnail, gender, notes, matching season, availability, brand, category, and price. If you look at the notebook, you can see that it's divided into top, heart, and base, and just to give you a quick explanation, the top note is a scent that you can smell for about 10 minutes from the moment you spray perfume to the time when alcohol evaporates. The heart note is a key scent that can be smelled for about three hours after that, and the base note is a scent that can be smelled gently three hours after spraying perfume. These three scents are organized into sections. 

6. (data collection: firebase)
 As a result, there are about 40,000 perfume models collected. In order to manage the data smoothly as well as the models of perfumes, data such as perfumes' brands, notes, categories, and seasons are separately defined and stored. So I collected all the data and stored it in json format, and I got about 1.4 million pieces. And I needed a place to put and manage a lot of this data, and the database server that played that role was firebase. So, after trimming the json shape in a form that can be recognized by firebase,

7. (data collection: firebase - 그림)
I registered the data set in the firebase like this. 
(Enter) - firebase2
So you can see that all the information on perfume that I mentioned earlier is properly included. 

8. (Recommendation Method)
 Then I'll tell you how to recommend this project. Since the data of perfumes is very large at 40,000 and the reviews are very small, we decided to use the contents based filtering method. When a user selects a perfume, it recommends other perfume models related to the perfume. 

9. (Cosine Similarity)
 So I used cosine similarity method as an algorithm to recommend this perfume. What you see on the right is what the code is about. Let's take a closer look at this. 
(Enter) - Caculation Equations
Let's say there are two perfume models 1 and 2. Model 1 has only the third category, and Model 2 has the second and third categories at the same time. Only 0 and 1 were used binary to express included and not included. So the lengths of the models 1 and 2 are Pythagorean, and in this example, we assume that the two models are five-dimensional vectors, and we have internal values like coordinates. Thus, the cosine value was obtained using the inner definition, and the finally calculated value is cosine simulation. 

10. (Model1 and Model2)
 We've just given you an example of a category, but I don't think the category is the only measure to compare the two models. For example, you might have a note. In this case, it was difficult to calculate the association, and the notes were divided into three layers, and sometimes the same notes corresponded to the same layer, and sometimes they corresponded to different layers. Therefore, it was calculated by dividing it into direct hit for direct response and indirect hit for indirect response. The weights of the two hits were set differently so that you could get more points when it was direct hit. 

11. Season:4
 So if you look at the measures that compare between the two perfumes, first there's a season. Since the season is divided into four categories, the expected value of the score is set relatively high. 
(Enter) - category
And there's a category, and since there are 12 categories, the expected value is relatively lower than before. 
(enter) - note
And finally, there are 973 notes that represent the ingredients of the scent. So the expected value of the score is very low. As I said before, 
(enter) - direct, indirect
direct hit and indirect hit
(enter) - Code illustration
With the difference between the two weights, the weights were defined and added as shown in the picture on the right. 

12. Weights
Season and category were multiplied by the number of cases according to the ratio of the expected value, and for note, 30 and 15 were added as the most appropriate weights after several tests. If the weight of the note is too large, the reason and category will be ignored, and if it is too small, the note will be ignored, so we set the weight as you can see to produce the most reasonable results.

13. AP@K
Next is evaluation. The evaluation of the recommended system was made using mean average decision @K, and the code on the right is the average decision part, which is the process before making mean average decision. Since Mean Average Precision is an average of many users after evaluating Average Precision, we put a code that calculates and registers Average Precision first.
(enter)
To calculate the average decision, you can look at the expression above. If you run the application, you will see the recommended list from 1st to 10th. The user will use the expression above to show the satisfaction of the result to see if the recommendation list was well recommended. If you look at the list of 1st to 10th place, isn't the accuracy of 1st place more important than 10th place? So we used this AP method, which is the method where the weight of the first place is the highest and the weight of the tenth place is the lowest. As an example, I'm going to show you briefly from 1st to 4th place. When users evaluate this app, if they are satisfied with the first and third places, but not satisfied with the second and fourth places, the evaluation table is organized like the table you see. The product of Precision i and relation i is shown as you can see. (Explain from the left in order of 1, 2, 3, and 4.)

* m = The number of items that the user liked. If you chose 7, 7.
* k = the number of precedents. Since we did the precedence 4 times, the precedence is 4.
* P(i) = the proportion of items that the user likes among the 1st to ith indexes
* rel(i) = whether the user liked the index, consisting of 1 and 0.

14. MAP@K
The average precedence of users, which was calculated in the way I mentioned earlier, is additionally registered in the database. To calculate MAP@K, access the stored DB and add the accumulated Average Precision to obtain the average. We implement an algorithm to obtain MAP@K in this way.

15. Implementaion
After talking about the implementation of the project, we will continue with the demo. We obtained normalized data using kaggle and basenote website crowling that I mentioned at first, and organized them in json form. This DB is saved in firebase. And we developed an Android app using a platter linked to this server. Recommendation and Evaluation are implemented on this flutter. That's how I created the Android APK file, and now I'm going to check out the demonstration video.

16. Demo
Before you watch the demo video, the source code has been posted on GitHub as public, and the link below is the download link that you can download and use APK. I've posted a link to GitHub, so you can download it from GitHub. Let me show you a demo video.

17. Lean Canvas
(Leftmost) ble
There was a problem that it was difficult for customers to choose their favorite perfume efficiently, and for now, the only way to solve this problem is to choose the perfumes that the seller recommended subjectively or smell them all.
(Most right) Customer
So this project is going to be these consumers. The project covers all ages from 20s to 50s or older.
(center) value
So the value of this project that I'm proposing to these consumers is that they no longer have to overwork their sense of smell to choose perfumes. 
(Second) Solution
This recommendation system will be able to provide enough perfumes for customers to like.
(Second lower) Key metrics
I think this perfume is a service that can be applied to all customers and any customers, and there is no service that provides this kind of service in the market, so I think it is worth it enough. 

18. Schedule
During the project, I focused on developing specific plans and collecting, structuring, and classifying data during November. And we started developing it at the front end in December, and we implemented the main functions first on a simple UI, and then improved the algorithm for the rest of the year and designed the UI by specifying it. That's how I was able to complete a project like this.

19. End
Thank you for listening to my presentation
