use src::sorcerer::Sorcerer;
use src::sorcerer::Talent;

fn duel(ref sorcerer1: Sorcerer, ref sorcerer2: Sorcerer) {
    // IMPLEMENT THIS FUNCTION

    let mut condition1 : u8 = 0;
    let mut condition2 : u8 = 0;

    match sorcerer1.talent {
        Talent::Talentless(_) => {
         },
        Talent::Venomous(_) => {
            condition1 = 1;
         },
        Talent::Swift(_) => {
            condition1 = 2;
        },
        Talent::Guardian(_) => {
            condition1 = 3;
         },
    }

    match sorcerer2.talent {
        Talent::Talentless(_) => {
         },
        Talent::Venomous(_) => {
            condition2 = 1;
         },
        Talent::Swift(_) => {
            condition2 = 2;
        },
        Talent::Guardian(_) => {
            condition2 = 3;
         },
    }

    // validate Swift talent
    if condition1 == 2 {
       if sorcerer2.attack < 4 {
            sorcerer2.attack = 1;
       }
    }
    if condition2 == 2 {
        if sorcerer1.attack < 4 {
             sorcerer1.attack = 1;
        }
     }

    let mut counter : u8 = 0;

    let initAt1 = sorcerer1.attack;
    let initAt2 = sorcerer2.attack;
    
    while sorcerer1.health > 0 && sorcerer2.health > 0 {

         // validate Guardian talent
        if condition1 == 3 {
            if sorcerer1.hasBeenDamaged == false{
                sorcerer1.hasBeenDamaged = true;
                if counter == 0 {
                    sorcerer2.attack = 0;
                }
            }
        }
        if condition2 == 3 {
            if sorcerer2.hasBeenDamaged == false{
                sorcerer2.hasBeenDamaged = true;
                if counter == 0 {
                    sorcerer1.attack = 0;
                }
            }
        }

        // exec the attackt
        sorcerer1.health = saturating_sub(sorcerer1.health, sorcerer2.attack);
        sorcerer2.health = saturating_sub(sorcerer2.health, sorcerer1.attack);

        if condition1 == 3 {
            if counter == 0 {
                sorcerer2.attack = initAt2;
            }
        }
        if condition2 == 3 {
            if counter == 0 {
                sorcerer1.attack = initAt1;
            }
        }
        
        
        // validate Venomous talent
        if condition1 == 1 {
            sorcerer1.attack += 1;
        }
        if condition2 == 1 {
            sorcerer2.attack += 1;
        }
        
        counter += 1;
    
    };

}

fn saturating_sub(a: u8, b: u8) -> u8 {
    if a < b {
        return 0;
    }
    a - b
}
