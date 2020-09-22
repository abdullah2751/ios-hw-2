import UIKit
/*:
 # الواجب الثالث: لعبة UNO
 
 تحتوي لعبة الأونو على ٤ ألوان و١٠ أرقام.
 - تتكرر الأرقام لكل لون مرتين. ماعدا الرقم صفر، يتواجد مرة واحدة للون الواحد.
- توجد هناك ورقتين Action Cards لكل لون.
 1. Draw
 2. Reverse
 3. Pass

*/


//: ![Uno Deck](deck.jpg)


/*:
 ### المطلوب:
#### الجزء الأول:
 -- قم بإنشاء struct باسم Card به  الصفات التالية
 * color: String
 * number: Int
 
 -- قم بإنشاء مصفوفة من نوع `Card` فارغة، ثم قم بملئها بالأرقام فقط مرة واحدة من دون ال action cards ومن دون تكرار كل رقم مرتين (تكرار الأرقام بونص 🎁)
 
 - Green: 0 -> 9
 - Red: 0 -> 9
 - Blue: 0 -> 9
 - Yellow: 0 -> 9
 
 #### الجزء الثاني:
-- قم بإنشاء دالة بداخل الستركت Card باسم  `imageName`والتي تقوم بإرجاع اسم الصورة للكرت. قم بفتح المجلد Resources الموجود بداخل الplayground من النافذة اليسرى لرؤية طريقة تسمية الكرت
 ###### مثال على تسمية الكروت موضحة كالتالي، قم بتشغيل الكود لرؤية الصور أسفل هذه الأكواد:
 */


var blue_5 = UIImage(named: "Blue_6.png")
var red_9 = UIImage(named: "Red_9.png")

var green_Skip = UIImage(named: "Green_Skip.png")
var wild_Draw = UIImage(named: "Wild_Draw.png")


/*:
 
 
 ### الجزء الثالث (تجريب الكود😍):
 قم بإزالة الملاحظة عن الأسطر الأخيرة لتجربة الكود إن كان يعمل بشكل مناسب،
 الجزء الأول سيظهر كرت عشوائي
 الجزء الثاني سيظهر مجموعة الكروت كاملة 🃏🎴
 ```
 let randomCard = cards.randomElement()!
 let randomCardImage = UIImage(named: randomCard.imageName())
```

 ```
 let cardImages = cards.map{UIImage(named: $0.imageName())}
 randomCardImage
 ```
 إن تم ذلك بالشكل الصحيح من دون أي خطأ، فقد نجحت في المهمة! 🎉
 
  #### الجزء الرابع (بونص 🎁):
 -- قم بتعبئة مجموعة الكروت كل رقم يعرض مرتين، إلا الصفر، يعرض مرة واحدة، كما هو موضح في صورة مجموعة الأونو في بداية الملف
 -- قم باستعمال For Loop لتعبئة جميع الكروت

 
 #### الجزء الخامس (إكسترا إكسترا بونص 🌶🔥)
 -- قم بتعبئة المصفوفة أيضاً ب Action Cards من خلال تحويلك للصفات إلى optional بإضافة علامة الاستفهام إليها
اسم ال Action Cards موضح في الصور بداخل ال Resources
 
 ```
 var color: String?
 var action: String?
 var number: Int?
 ```
  لا تنسى إزالة كلمة  Optional بسبب تحويلك للمتغيرات إلى متغيرات بعلامة الاستفهام. ربما ستضطر إلى كتابة بعض أوامر if
  
 */


//: ---

//: # الحل ...
//حاولت اسوي الواجب بطريقه من بره المنهج و ازيد عليه اشياء و كلها شفتها بالنت و تقريبا تسوي لعبه الاونو كامله
//التعليقات الموجوده تشرح وظيفه الكود و اغلبها بالعربي
//و آسف اني تأخرت لي آخر يوم تسليم بس احتجت وقت علشان افهمه هدل و اشرحه 🤓

// البطاقات المميزه.
enum Joker: String, CaseIterable {
    // بس اربع نسخ بتكون موجوده
    case joker, drawFour, swapCircle
    func points() -> Int {
        switch self {
        case .joker, .drawFour, .swapCircle: return 50
        }
    }
}

// البطاقات العاديه.
enum Value: String, CaseIterable {
    
    case one, two, three, four, five, six, seven, eight, nine, drawTwo, skip, turn
    
    func points() -> Int {
        switch self {
        
        case .one: return 1
        case .two: return 2
        case .three: return 3
        case .four: return 4
        case .five: return 5
        case .six: return 6
        case .seven: return 7
        case .eight: return 8
        case .nine: return 9
        case .drawTwo, .skip, .turn: return 20
        }
    }
}
// كل الألوان.
enum Color: String, CaseIterable {
    case red, blue, yellow, green
}

// تبين نوع الكرت
struct Card {
    let value: Value? // is nil when card is a joker
    let color:  Color? // is nil when card is a joker
    let joker:  Joker? // is nil when card has a value and color
}

// يسوي مكانين حق الكروت واحد الي يتوزع على اللاعبين و الثاني الي يسحبون منه ياللعبه
class Stack {
    public var stack: [Card]

    // تسوي القرعه
    private static func createDrawStack(with amountOfCards: Int) -> [Card] {
        var cards = [Card]()
        // اضافه كرتين من نفس القيمه
        for color in Color.allCases {
            for value in Value.allCases {
                for _ in 0..<amountOfCards { // اضافه نسختين
                    cards += [Card(value: value, color: color, joker: nil)]
                }
            }
        }
        for _ in 0..<(amountOfCards * 2) {
            // add 1 swap-circle
            cards += [Card(value: nil, color: nil, joker: .swapCircle)]
            // add 1 draw-four
            cards += [Card(value: nil, color: nil, joker: .drawFour)]
            // add 1 joker
            cards += [Card(value: nil, color: nil, joker: .joker)]
        }
        return cards.shuffled()
    }

    //يسوي المكان الي تكون الكروت موجوده فيه
    private static func createGameStack(with drawStack: Stack) -> [Card] {
        guard let topCard = drawStack.stack.popLast() else {
            print("Why is the drawStack empty?")
            return []
        }

        return [topCard]
    }
    init(createDrawStackWith amount: Int) {
        self.stack = Stack.createDrawStack(with: amount)
    }
    init(createGameStackWith drawStack: Stack) {
        self.stack = Stack.createGameStack(with: drawStack)
    }
}

// تبين اللاعب و شنو الاشياء الي قدر يسويها
class Player {
    let id: Int
    var hand = [Card?]()
    var didDraw = false

    // يستلم نوع البطاقه و يحددها
    public func wantsToPlayCard(at index: Int) -> Card {
        return hand[index]!
    }

    // تاخذ الكرت من اللاعب لي مكان الكروت
    public func playCard(at index: Int, onto playStack: Stack) {
        if let card = self.hand.remove(at: index) {
            playStack.stack.append(card)
        }
    }

    // يودي الكرت حق اللاعب
    public func drawCard(from deck: Stack) {
        self.hand.append(deck.stack.popLast()!)
    }

    init(withID id: Int) {
        self.id = id
    }
}

// اهم شي باللعبه(الاساس)
class Uno {

    public var drawStack: Stack // creates a stack to draw from with 2 copies of each color
    public var playStack: Stack // creates a stack where the game will be played
    public var players: [Player] // will be initialized dependent of amount

    // ياخذ الاوراق و يرجعها حق المكان الي يوزعها
    public func resetDrawStack() {
        let topCard = playStack.stack.popLast()! // save top card
        drawStack.stack = playStack.stack // move rest of playStack back into drawStack
        drawStack.stack.shuffle()
        playStack.stack.removeAll()
        playStack.stack += [topCard]
    }

    // تأكيد إذا كان اللاعب يقدر يستخدم الكرت
    public func cardsMatch(compare topCard: Card, with handCard: Card) -> Bool {
        // if colors match
        if let colorTopCard = topCard.color, let colorHandCard = handCard.color {
            if colorTopCard == colorHandCard {
                return true
            }
        }
        // إذا كانت النتيجه مطابقه
        if let valueTopCard = topCard.value, let valueHandCard = handCard.value {
            if valueTopCard == valueHandCard {
                return true
            }
        }
        // اذا كانت مميزه
        if let _ = handCard.joker {
            return true
        }
        // else
        return false
    }

    // يجهز الكروت ببدايه الجوله
    private func dealCards(with amountOfCards: Int) {
        for id in players.indices {
            for _ in 0..<amountOfCards {
                players[id].drawCard(from: drawStack)
            }
        }
    }

    // تصنع اللاعبين
    private static func createPlayers(with amountOfPlayers: Int) -> [Player] {
        var players = [Player]()
        for id in 0..<amountOfPlayers {
            players += [Player(withID: id)]
        }
        return players
    }

    // يبني اللعبه(يعامد على الاعدادات)
    init(amountOfPlayers: Int, amountOfCopies: Int, amountOfCards: Int) {
        self.drawStack = Stack(createDrawStackWith: amountOfCopies)
        print(self.drawStack.stack)
        self.playStack = Stack(createGameStackWith: self.drawStack)
        self.players = Uno.createPlayers(with: amountOfPlayers) // creates 2 players
        self.dealCards(with: amountOfCards)
    }
}

var game = Uno(amountOfPlayers: 2, amountOfCopies: 2, amountOfCards: 7)
