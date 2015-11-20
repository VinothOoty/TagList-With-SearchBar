

#import "Search.h"

@implementation Search


@synthesize brand;

-(id)initWithBrandName:(NSString*)thebrandName
{
    self = [super init];
    if(self)
    {
        self.brand =thebrandName;
    }
    return self;
}


@end
