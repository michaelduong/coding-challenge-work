# ios-code-exercise

## Thank you for taking the time to review this project 🎉
• Built and compiled with Xcode 12.0 beta 5
• Made to run on iOS 12+ (initial project settings was 11.2, honestly should work on 11.0+)
• Focus was on UI and architecture

### Third Party dependencies used:
• Stevia
This was used for purely auto layout synthetic suger. This library makes working with autolayout and constraints soooo much easier and cleaner to read. In the past I used to bring in my own helper autolayout wrapper class but this library blows it out of the water. If you're a purist, I hope we can see eye-to-eye that more concise and less code is easier to comprehend long term — especially for those who come into the codebase after us :)

• Kingfisher
This library was used for caching images retrieved from the JSON payload. It has built in placeholder, loading (downloading) activity indicators, downsampling, and rounded corner processing.

### Architecture:
• MVVM
• Dependency injection
• Dependency inversion
• SRP

I tried to follow SOLID principles as much as possible. I took time abstracting the data layer into proper interfaces/protocols so that the codebase was more easily testable and extensible for the future. I am utilizing separate structs (found in the Helpers directory) for Strings, Colors, Layouts, Fonts, Images — this allows for better consistency and less typing, it's nice to take advantage of Swift's strongly typed identifiers.

### Code Structure

I cleaned up the main view controller a bit. The goal was to keep it as lean as possible. Some enhancements I did were abstract out the data source and view into their own files and then referenced them from the view controller. I had to go with a custom tableview cell since the default one wouldn't quite cut it based on the design specs provided. I figured I'd add in some opportunities to showcase my design/UI abilities by altering the stock layout/UI a bit. I mocked out a quick design in Sketch (file included) to include empty state, warning state (corresponding with deny list match), and no result state for when there are no results to display.

Moving on to the meat of the app is the data layer. Starting with the List Manager and List Importer classes, these objects solely handle importing the deny list from the app bundle, retrieving the list (from User defaults), saving the list to disk, and lastly writing to the list. The deny list from the bundle is just a way to initially start the app off with 100 black list search terms, but as per requirements we need a way to continue to add to the list for empty result search terms. Since the denylist.txt file that's bundled with the app is read-only, we needed a way to continuously read, append/write, and save our denied search terms. The two ways I came up with were either saving a copy of the denylist.txt to the app's document directory or saving the entire array in UserDefaults. The latter was a much simpler solution however the former could easily be achieved as well by writing to the file and reading from it every time. The requirements weren't very clear on how "if the API returns no results, the search term is added to the denylist" so my solution using UserDefaults fit that ambiguous request. 

The actual validation of the search term utilized a Trie. The Validator class is a singleton that contains reference to a root (node), a ValidatorNode class and exposes methods to insert into the Trie, check if a word is contained in the trie, and also check if the prefix starts with anything found in the denylist. I initially was going to go with plain old contains method on an array collection type but thought to myself if the denylist was massive, we'd run into performance issues. We can improve upon this by doing a binary search on the array but that would require sorting the array first before we can execute the binary search. In the end, because the requirements dictated that the search term had to match OR start with anything found in the denylist, a Trie was perfectly suited for this type of job. 

I added in a caching layer for offline support and to speed up performance. This helps with cutting down necessary network requests because an API call is fired off every time the user finishes typing in the search textfield. I also modified textFieldDidChange to textFieldDidEndEditing just to cut down on the amount of times it fired off even more. The caching layer is once again persisted every time and saved to user defaults. An ORM/database would have been overkill since we don't need any complex lookups or indexing.

### Future Enhancements

I noticed the network layer didn't have error handling so I exposed the errors that could be caught to bubble up the call stack in the completion handler. I segregated and categorized them into its own RequestError enum so that the error can be identifiable and easily dealt with from a front-end perspective. Now we could handle this from the view model layer to tell the view layer to display some kind of UIAlertView or update the UI itself to reflect errors. I didn't add this in since I felt I was already going beyond the scope of this project.

If we really cared about performance of our denylist matching, there are several improvements we could pursue. One would be using a Set instead. This doesn't allow for duplicates and has a O(1) lookup time. Other potential improvements would be altering the searching algorithm to utilize Knuth-Morris-Pratt or Boyer-Moore algorithm. 
