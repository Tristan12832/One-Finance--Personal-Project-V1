#  Note: One Finance

Translate information: the translation was done thanks to Deepl and from FR to EN. 

During the creation of the One Finance application, which is my 3rd application entirely designed and created by myself. I encountered absolute problems at my learning stage. 

Below, you'll find a list of the problems and future improvements I'd like to make to this application so that I can one day use it in everyday life.

## Problems and more 
* Data not synchronized between the **AccountDetailView** view and the other views; note that I solved my problem using a little trick: by placing an @Query in my AccountDetailView view to "force" the view to be updated as well as all the other views).
    * My problem was when I had more than one account and I deleted a transaction in the transaction list, my transaction was indeed deleted but without updating all the other views that communicated with the computed variable **(totalExpense)**, yet when I restarted my application, all the different views and computed variables were updated.
* Missing: in the application I've put in several charts using Apple's Chart API, which allows you to create simple and beautiful charts, just by giving the data from a model (...). My shortcoming is that I haven't yet worked enough with this API to explore all the accessibility possibilities, even though by default the API provides several accessibility aids, including "audio chart". 
* Missing: During the creation of the application, there were major changes in the SwiftUI framework and the introduction of SwiftData (which greatly simplifies the creation of data models in applications, particularly those based on SwiftUI). So, I had to migrate my project during its creation with my limited experience, it was sometimes frustrating to understand all the changes, especially those related to the operation of the "new way" to create and manage the great feature of SwiftUI, the "Live Preview / Preview". as a result, I don't necessarily know how to create my previews in the most adequate way possible. In the future, I'll improve this point too.


