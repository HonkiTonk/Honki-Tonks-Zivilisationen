pragma SPARK_Mode (On);

with GlobaleKonstanten;

with LeseEinheitenGebaut, LeseEinheitenDatenbank;

with StadtSuchen, GesamtwerteFeld;

package body KampfwerteEinheitErmitteln is

   -- Mit_Hügel noch berücksichtigen
   function AktuelleVerteidigungEinheit
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      AngreiferExtern : in Boolean)
      return GlobaleDatentypen.GesamtproduktionStadt
   is begin
      
      VerteidigungWert := LeseEinheitenDatenbank.Verteidigung (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                               IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      
      case
        AngreiferExtern
      is
         when False =>
            Bonus := VerteidigungsbonusVerteidiger (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when True =>
            Bonus := VerteidigungsbonusAngreifer;
      end case;
      
      if
        VerteidigungWert + Bonus > GlobaleDatentypen.GesamtproduktionStadt'Last
      then
         return GlobaleDatentypen.GesamtproduktionStadt'Last;
         
      else
         return VerteidigungWert + Bonus;
      end if;
      
   end AktuelleVerteidigungEinheit;
   
   
   
   function VerteidigungsbonusVerteidiger
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.GesamtproduktionStadt
   is begin
      
      VerteidigungWertFloat := Float (GesamtwerteFeld.FeldVerteidigung (KoordinatenExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                                        RasseExtern       => EinheitRasseNummerExtern.Rasse));
      
      case
        LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
      is
         when GlobaleDatentypen.Verschanzen =>
            VerteidigungWertFloat := VerteidigungWertFloat * VerschanzungBonus;
                  
         when others =>
            null;
      end case;
            
      case
        StadtSuchen.KoordinatenStadtMitRasseSuchen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                    KoordinatenExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
      is
         when GlobaleKonstanten.LeerEinheitStadtNummer =>
            null;
                  
         when others =>
            VerteidigungWertFloat := VerteidigungWertFloat * StadtBonus;
      end case;
              
      if
        VerteidigungWertFloat > Float (GlobaleDatentypen.GesamtproduktionStadt'Last)
      then
         return GlobaleDatentypen.GesamtproduktionStadt'Last;
               
      else
         return GlobaleDatentypen.GesamtproduktionStadt (VerteidigungWertFloat);
      end if;
      
   end VerteidigungsbonusVerteidiger;
   
   
   
   function VerteidigungsbonusAngreifer
     return GlobaleDatentypen.GesamtproduktionStadt
   is begin
      
      return 0;
      
   end VerteidigungsbonusAngreifer;
   
   
   
   function AktuellerAngriffEinheit
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      AngreiferExtern : in Boolean)
      return GlobaleDatentypen.GesamtproduktionStadt
   is begin
      
      AngriffWert := LeseEinheitenDatenbank.Angriff (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                     IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      
      case
        AngreiferExtern
      is
         when True =>
            Bonus := AngriffsbonusAngreifer (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when False =>
            Bonus := AngriffsbonusVerteidiger;
      end case;
     
      if
        AngriffWert + Bonus > GlobaleDatentypen.GesamtproduktionStadt'Last
      then
         return GlobaleDatentypen.GesamtproduktionStadt'Last;
         
      else
         return AngriffWert + Bonus;
      end if;
   
   end AktuellerAngriffEinheit;
   
   
   
   function AngriffsbonusAngreifer
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.GesamtproduktionStadt
   is begin
      
      AngriffWertFloat := Float (GesamtwerteFeld.FeldAngriff (KoordinatenExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                              RasseExtern       => EinheitRasseNummerExtern.Rasse));
            
      -- Diesen Bonus anders gestalten, vielleicht auf Basis der Bewegungspunkte?
      AngriffWertFloat := AngriffWertFloat * AngriffBonus;
            
      if
        AngriffWertFloat > Float (GlobaleDatentypen.ProduktionFeld'Last)
      then
         return GlobaleDatentypen.GesamtproduktionStadt'Last;
               
      else
         return GlobaleDatentypen.GesamtproduktionStadt (AngriffWertFloat);
      end if;
      
   end AngriffsbonusAngreifer;
   
   
   
   function AngriffsbonusVerteidiger
     return GlobaleDatentypen.GesamtproduktionStadt
   is begin
      
      return 0;
      
   end AngriffsbonusVerteidiger;

end KampfwerteEinheitErmitteln;
