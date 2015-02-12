//
//  QuizViewController.m
//  QuizSample
//
//  Created by Master on 2014/11/01.
//  Copyright (c) 2014年 net.masuhara. All rights reserved.
//

#import "QuizViewController.h"


@interface QuizViewController ()
<UIAlertViewDelegate>

@end

@implementation QuizViewController

{
    int currentQuiz;
    int correctAnswer;
    AVAudioPlayer *questionSound, *correctSound, *incorrectSound;
    NSMutableArray *quizArray;
    IBOutlet UITextView *problemTextView;
    IBOutlet UIImageView *quizImageView;
    IBOutlet UIButton *buttonA, *buttonB, *buttonC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    currentQuiz = 0;
    correctAnswer = 0;
    
    quizArray = [[NSMutableArray alloc] init];
    [self setQuiz];
     quizArray = [self shuffleQuiz:[self setQuiz]];
    
    buttonA.tag = 1;
    buttonB.tag = 2;
    buttonC.tag = 3;
    
    [self setSounds];
    [self setQuestions];
}

- (void)viewDidAppear:(BOOL)animated
{
    [questionSound play];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



- (NSMutableArray *)shuffleQuiz:(NSMutableArray *)qArray
{
    int numberOfQuiz = (int)[qArray count];
    
    for (int i = numberOfQuiz - 1; i > 0; i--) {
        int randNumber = arc4random() % i;
        [qArray exchangeObjectAtIndex:i withObjectAtIndex:randNumber];
    }
    
    NSLog(@"問題一覧 %@", qArray);
    
    return qArray;
}



#pragma mark - IBAction

- (IBAction)selectAnswer:(UIButton *)selectedButton
{
    if (selectedButton.tag == [[quizArray[currentQuiz] objectAtIndex:0] intValue]) {
        //正解だったとき
        [correctSound play];
        correctAnswer++;
    }else{
        //不正解だったとき
        [incorrectSound play];
    }
    
    currentQuiz++;
    [self setQuestions];
}


#pragma mark - Sounds

- (void)setSounds
{
    //問題が出たときの音
    NSString *questionSoundPath = [[NSBundle mainBundle] pathForResource:@"question" ofType:@"wav"];
    NSURL *questionSoundURL = [NSURL fileURLWithPath:questionSoundPath];
    
    //正解したときの音
    NSString *correctSoundPath = [[NSBundle mainBundle] pathForResource:@"correct" ofType:@"wav"];
    NSURL *correctSoundURL = [NSURL fileURLWithPath:correctSoundPath];
    
    //不正解だったときの音
    NSString *incorrectSoundPath = [[NSBundle mainBundle] pathForResource:@"incorrect" ofType:@"wav"];
    NSURL *incorrectSoundURL = [NSURL fileURLWithPath:incorrectSoundPath];
    
    
    questionSound = [[AVAudioPlayer alloc] initWithContentsOfURL:questionSoundURL error:nil];
    correctSound = [[AVAudioPlayer alloc] initWithContentsOfURL:correctSoundURL error:nil];
    incorrectSound = [[AVAudioPlayer alloc] initWithContentsOfURL:incorrectSoundURL error:nil];
    
    [questionSound prepareToPlay];
    [correctSound prepareToPlay];
    [incorrectSound prepareToPlay];
}



#pragma mark - Quiz

- (NSMutableArray *)setQuiz
{
    [quizArray addObject:[NSArray arrayWithObjects:@"1", [UIImage imageNamed:@"image1"], @"この電車はいつ走っていた？", @"明治時代", @"昭和初期", @"戦後", nil]];
    [quizArray addObject:[NSArray arrayWithObjects:@"1", [UIImage imageNamed:@"image2"], @"手前の青いのはどこの電車？", @"メトロ", @"小田急", @"りんかい線", nil]];
     [quizArray addObject:[NSArray arrayWithObjects:@"1", [UIImage imageNamed:@"image6"], @"この機関車が走ってるのはどこ？", @"関門トンネル", @"青函トンネル", @"瀬戸大橋", nil]];
    [quizArray addObject:[NSArray arrayWithObjects:@"3", [UIImage imageNamed:@"image5"], @"この車両は何？", @"ディーゼルカー", @"燃料電池車", @"ガソリン気動車", nil]];
    [quizArray addObject:[NSArray arrayWithObjects:@"2", [UIImage imageNamed:@"image4"], @"これはどこで走ってた電車？", @"名鉄", @"京急", @"東急", nil]];
    [quizArray addObject:[NSArray arrayWithObjects:@"3", [UIImage imageNamed:@"image3"], @"ここどこ？", @"秋田", @"長野", @"新潟", nil]];
    [quizArray addObject:[NSArray arrayWithObjects:@"2", [UIImage imageNamed:@"image8"], @"この車両が起こした日本最悪の列車火災事故は何？", @"横浜事故", @"桜木町事故", @"渋谷事故", nil]];
    [quizArray addObject:[NSArray arrayWithObjects:@"2", [UIImage imageNamed:@"image7"], @"この電車がもともと走っていたところはどこ？", @"東横線", @"京王線", @"山手線", nil]];
    [quizArray addObject:[NSArray arrayWithObjects:@"2", [UIImage imageNamed:@""], @"この電車は何？",@"151系",@"171系",@"181系",nil]];
    [quizArray addObject:[NSArray arrayWithObjects:@"1", [UIImage imageNamed:@""], @"この電車は何を改造して作られた？",@"119系",@"キハ110",@"115系",nil]];
    [quizArray addObject:[NSArray arrayWithObjects:@"3", [UIImage imageNamed:@""], @"この電車の特徴は？"
                          ,@"電圧の変化に対応できる",@"車輪の幅を変えられる",@"併用軌道を走れる",nil]];
    [quizArray addObject:[NSArray arrayWithObjects:@"1", [UIImage imageNamed:@""], @"この新幹線の鼻に入っているのは何？",@"連結器",@"空気圧縮機",@"水タンク",nil]];
    [quizArray addObject:[NSArray arrayWithObjects:@"2", [UIImage imageNamed:@""], @"これは何線？"
                          ,@"京葉線",@"近鉄線",@"京急線",nil]];
    [quizArray addObject:[NSArray arrayWithObjects:@"1", [UIImage imageNamed:@""], @"ここ、どこ？"
                          ,@"長崎駅",@"博多駅",@"門司港駅",nil]];
    [quizArray addObject:[NSArray arrayWithObjects:@"2", [UIImage imageNamed:@""], @"この客車は何？"
                          ,@"24系",@"14系",@"E4系",nil]];
    [quizArray addObject:[NSArray arrayWithObjects:@"1", [UIImage imageNamed:@""], @"ここ,どこ？"
                          ,@"博多南駅",@"美濃太田駅",@"新神戸駅",nil]];
    [quizArray addObject:[NSArray arrayWithObjects:@"3", [UIImage imageNamed:@""], @"この鉄道は何？"
                          ,@"九州鉄道",@"西日本鉄道",@"島原鉄道",nil]];
    [quizArray addObject:[NSArray arrayWithObjects:@"2", [UIImage imageNamed:@""], @"この列車は何？"
                          ,@"キハ676系",@"キハ67系",@"67系",nil]];
    [quizArray addObject:[NSArray arrayWithObjects:@"3", [UIImage imageNamed:@""], @"ここ、どこ？"
                          ,@"鹿児島駅",@"長崎駅系",@"佐世保駅",nil]];
    [quizArray addObject:[NSArray arrayWithObjects:@"2", [UIImage imageNamed:@""], @"これはなんの車庫？"
                          ,@"路線バス",@"鉄道",@"タクシー",nil]];
    [quizArray addObject:[NSArray arrayWithObjects:@"1", [UIImage imageNamed:@""], @"この列車の名前は？"
                          ,@"ムーンライトながら",@"シュプール中部",@"急行ながら",nil]];
    [quizArray addObject:[NSArray arrayWithObjects:@"2", [UIImage imageNamed:@""], @"ここ、どこ？"
                          ,@"田沢湖駅",@"ほっとゆだ駅",@"新庄駅",nil]];
    [quizArray addObject:[NSArray arrayWithObjects:@"2", [UIImage imageNamed:@""], @"この客車は何？"
                          ,@"24系",@"14系",@"E4系",nil]];
    [quizArray addObject:[NSArray arrayWithObjects:@"1", [UIImage imageNamed:@""], @"この電車は何？"
                          ,@"サンライズ号",@"サンシャイン号",@"フルーツオレ号",nil]];
    [quizArray addObject:[NSArray arrayWithObjects:@"3", [UIImage imageNamed:@""], @"ここ、どこ？"
                          ,@"新花巻駅",@"仙台駅",@"盛岡駅",nil]];
    [quizArray addObject:[NSArray arrayWithObjects:@"1", [UIImage imageNamed:@""], @"これはなんの運転台？"
                          ,@"101系",@"201系",@"301系",nil]];
    [quizArray addObject:[NSArray arrayWithObjects:@"1", [UIImage imageNamed:@""], @"これは何線？"
                          ,@"北近畿タンゴ鉄道",@"山陽本線",@"福知山線",nil]];
    [quizArray addObject:[NSArray arrayWithObjects:@"2", [UIImage imageNamed:@""], @"これは何バス？"
                          ,@"西東京バス",@"近鉄バス",@"国際興業バス",nil]];
    [quizArray addObject:[NSArray arrayWithObjects:@"3", [UIImage imageNamed:@""], @"これは何線？"
                          ,@"宮崎鉄道",@"熊本電鉄",@"松原鉄道",nil]];
    [quizArray addObject:[NSArray arrayWithObjects:@"2", [UIImage imageNamed:@""], @"東武で貨物列車はいつまで走ってた？"
                          ,@"2003",@"2004",@"2005",nil]]; 
    
    
    return quizArray;
}


- (void)setQuestions
{
    if (currentQuiz < quizArray.count) {
        UIImage *image = [quizArray[currentQuiz] objectAtIndex:1];
        if ([image isKindOfClass:[UIImage class]] && image == nil) {
            quizImageView.image = [quizArray[currentQuiz] objectAtIndex:1];
            problemTextView.text = [quizArray[currentQuiz] objectAtIndex:2];
            [buttonA setTitle:[quizArray[currentQuiz] objectAtIndex:3] forState:UIControlStateNormal];
            [buttonB setTitle:[quizArray[currentQuiz] objectAtIndex:4] forState:UIControlStateNormal];
            [buttonC setTitle:[quizArray[currentQuiz] objectAtIndex:5] forState:UIControlStateNormal];
        }
    }else{
        NSString *messageString = [NSString stringWithFormat:@"%d問中、%d問正解でした！",currentQuiz, correctAnswer];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"結果" message:messageString delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
    }
}

#pragma mark - UIAlertView Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
        default:
            break;
    }
}

@end
