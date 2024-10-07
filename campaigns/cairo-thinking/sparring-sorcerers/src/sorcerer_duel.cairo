use src::sorcerer::{Sorcerer, SorcererTrait, Talent};

fn duel(ref sorcerer1: Sorcerer, ref sorcerer2: Sorcerer) {
    let mut guardian1_used = false;
    let mut guardian2_used = false;

    loop {
        // Calculate damages
        let mut damage1 = sorcerer1.attack();
        let mut damage2 = sorcerer2.attack();

        // Apply Swift talent effect
        if let Talent::Swift(_) = sorcerer1.talent {
            if damage2 > 0 && damage2 < 4 {
                damage2 = 1;
            }
        }
        if let Talent::Swift(_) = sorcerer2.talent {
            if damage1 > 0 && damage1 < 4 {
                damage1 = 1;
            }
        }

        // Apply Guardian talent effect
        if let Talent::Guardian(_) = sorcerer1.talent {
            if !guardian1_used {
                damage2 = 0;
                guardian1_used = true;
            }
        }
        if let Talent::Guardian(_) = sorcerer2.talent {
            if !guardian2_used {
                damage1 = 0;
                guardian2_used = true;
            }
        }

        // Apply damages and update health
        let new_health1 = if damage2 >= sorcerer1.health() { 0 } else { sorcerer1.health() - damage2 };
        let new_health2 = if damage1 >= sorcerer2.health() { 0 } else { sorcerer2.health() - damage1 };

        // Apply Venomous talent effect and update attack
        let new_attack1 = if let Talent::Venomous(_) = sorcerer1.talent {
            if new_health1 > 0 { sorcerer1.attack() + 1 } else { sorcerer1.attack() }
        } else {
            sorcerer1.attack()
        };

        let new_attack2 = if let Talent::Venomous(_) = sorcerer2.talent {
            if new_health2 > 0 { sorcerer2.attack() + 1 } else { sorcerer2.attack() }
        } else {
            sorcerer2.attack()
        };

        // Update sorcerer states
        sorcerer1 = SorcererTrait::new(new_attack1, new_health1);
        sorcerer2 = SorcererTrait::new(new_attack2, new_health2);

        // Check if the duel is over
        if new_health1 == 0 || new_health2 == 0 {
            break;
        }
    }
}