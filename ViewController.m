// ViewController.m
// RSSReader
//
// Created by Nachiket Shilwant on 23/08/24.
//

#import "ViewController.h"
#import "firstScreenTableViewCell.h"
#import "SecondViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *addBtn;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<NSDictionary<NSString *, NSString *> *> *listOfTopics;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.listOfTopics = [NSMutableArray arrayWithObjects:
                         @{@"Top Stories": @"https://feeds.bbci.co.uk/news/rss.xml"},
                         @{@"World": @"http://feeds.bbci.co.uk/news/world/rss.xml"},
                         @{@"UK": @"http://feeds.bbci.co.uk/news/uk/rss.xml"},
                         @{@"Business": @"http://feeds.bbci.co.uk/news/business/rss.xml"},
                         @{@"Politics": @"http://feeds.bbci.co.uk/news/politics/rss.xml"},
                         @{@"Health": @"http://feeds.bbci.co.uk/news/health/rss.xml"},
                         @{@"Education & Family": @"http://feeds.bbci.co.uk/news/education/rss.xml"},
                         @{@"Science & Environment": @"http://feeds.bbci.co.uk/news/science_and_environment/rss.xml"},
                         @{@"Technology": @"http://feeds.bbci.co.uk/news/technology/rss.xml"},
                         @{@"Entertainment & Arts": @"http://feeds.bbci.co.uk/news/entertainment_and_arts/rss.xml"},
                         nil];
    
    [self setupViews];
}

- (void)setupViews {
    [self setupTitleLabel];
    [self setupTableView];
}

- (void)setupTitleLabel {
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = @"RSS Reader NewsApp";
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.titleLabel setFont:[UIFont boldSystemFontOfSize:30]];
    [self.view addSubview:self.titleLabel];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
        [self.titleLabel.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:20],
        [self.titleLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.titleLabel.widthAnchor constraintEqualToConstant:350],
        [self.titleLabel.heightAnchor constraintEqualToConstant:50]
    ]];
}

- (void)setupTableView {
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[firstScreenTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
        [self.tableView.topAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor constant:20],
        [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
    ]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listOfTopics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    firstScreenTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSDictionary *topic = self.listOfTopics[indexPath.row];
    NSString *title = topic.allKeys.firstObject;
    [cell.urlAdded setTitle:title forState:UIControlStateNormal];
    [cell.urlAdded setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    cell.urlAdded.tag = indexPath.row;
    [cell.urlAdded addTarget:self action:@selector(presentSecondViewController:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (void)presentSecondViewController:(UIButton *)sender {
    NSInteger index = sender.tag;
    NSDictionary *selectedTopic = self.listOfTopics[index];
    NSString *selectedURL = selectedTopic[selectedTopic.allKeys.firstObject];
    
    SecondViewController *secondVC = [[SecondViewController alloc] init];
    secondVC.url = selectedURL;
    secondVC.modalPresentationStyle = UIModalPresentationFullScreen;
    
    [self presentViewController:secondVC animated:YES completion:nil];
}

@end
