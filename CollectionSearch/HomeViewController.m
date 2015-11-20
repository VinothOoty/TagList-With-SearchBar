//
//  HomeViewController.m
//  CollectionSearch
//
//  Created by SYZYGY01 on 19/11/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()


@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden =TRUE;

    [self.collectionObj setAllowsMultipleSelection:YES];
    [self.collectionObj registerNib:[UINib nibWithNibName:@"CollectionCell" bundle:nil] forCellWithReuseIdentifier:@"CollectionCell"];
    
    allArray =[[NSMutableArray alloc]init];
    BrandArray =[[NSMutableArray alloc]initWithObjects:@"One",@"Two",@"Three",@"Four",@"Five",@"Six", nil];

    
    for (int i=0; i<BrandArray.count; i++)
    {
        [allArray addObject:[[Search alloc]initWithBrandName:[BrandArray objectAtIndex:i]]];
    }
    [self.collectionObj reloadData];
}


//Collection View Methods//

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section
{
    NSUInteger rowCount;
    if(isFiltered)
    {
        rowCount = [BrandArray count];
    }
    
    else
    {
        rowCount = [allArray count];
    }
    return rowCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionCell" forIndexPath:indexPath];
    Search* Search;
    if(isFiltered)
        Search = [BrandArray objectAtIndex:indexPath.row];
    else
        Search = [allArray objectAtIndex:indexPath.row];

    cell.frst.text =[NSString stringWithFormat:@"%@",Search.brand];
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rounded.png"]];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    Search* Search;
    if(isFiltered)
        Search = [BrandArray objectAtIndex:indexPath.row];
    else
        Search = [allArray objectAtIndex:indexPath.row];
    NSLog(@"Clicked %@",Search.brand);
    
    
    UICollectionViewCell *selectedCell =
    [collectionView cellForItemAtIndexPath:indexPath];
  
    [selectedCell.superview bringSubviewToFront:selectedCell];
    [UIView transitionWithView:selectedCell
                      duration:0.2
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    animations:^{
                       
                        selectedCell.backgroundView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"roundedblue.png"]];
                        selectedCell.transform = CGAffineTransformMakeRotation(0.0);
                    }
                    completion:^(BOOL finished) {}];
    
    

}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *deselectedCell =
    [collectionView cellForItemAtIndexPath:indexPath];
    
    [deselectedCell.superview bringSubviewToFront:deselectedCell];
    [UIView transitionWithView:deselectedCell
                      duration:0.2
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    animations:^{
                        
                        deselectedCell.backgroundView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rounded.png"]];

                        deselectedCell.transform = CGAffineTransformMakeRotation(0.0);
                    }
                    completion:^(BOOL finished) {}];
    
    deselectedCell.backgroundView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rounded.png"]];
}

#pragma mark Search

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [self.searchObj becomeFirstResponder];
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [self.searchObj resignFirstResponder];
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if(searchText.length == 0)
    {
        isFiltered = FALSE;
        [self.view endEditing:YES];
    }
    else
    {
        isFiltered = true;
        BrandArray = [[NSMutableArray alloc] init];
        for (Search* search in allArray)
        {
            NSRange nameRange = [search.brand rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if(nameRange.location != NSNotFound )
            {
                [BrandArray addObject:search];
            }
        }
    }
    [self.collectionObj reloadData];
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)SearchBar
{
    [self.searchObj resignFirstResponder];
}


#pragma mark Text Field

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)searchString
{
    if(searchString.length == 0)
    {
        isFiltered = FALSE;
        [self.view endEditing:YES];
    }
    else
    {
        isFiltered = true;
        BrandArray = [[NSMutableArray alloc] init];
        for (Search* search in allArray)
        {
            NSRange nameRange = [search.brand rangeOfString:searchString options:NSCaseInsensitiveSearch];
            if(nameRange.location != NSNotFound )
            {
                [BrandArray addObject:search];
            }
        }
    }
    [self.collectionObj reloadData];
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if(textField.text.length == 0)
    {
        [self.textSearch resignFirstResponder];
        return YES;
    }
    else
    {
        [self.textSearch resignFirstResponder];
        return NO;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.textSearch resignFirstResponder];
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)addButton:(id)sender
{
    self.textSearch.text =@"";
    [self.textSearch resignFirstResponder];
}
@end
