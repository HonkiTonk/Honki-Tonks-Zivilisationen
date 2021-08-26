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
            if
              VerteidigungWert + GesamtwerteFeld.FeldVerteidigung (KoordinatenExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                                   RasseExtern       => EinheitRasseNummerExtern.Rasse)
              > GlobaleDatentypen.ProduktionFeld'Last
            then
               VerteidigungWert := GlobaleDatentypen.ProduktionFeld'Last;
               
            else
               VerteidigungWert := VerteidigungWert + GesamtwerteFeld.FeldVerteidigung (KoordinatenExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                                                        RasseExtern       => EinheitRasseNummerExtern.Rasse);
            end if;
            
            VerteidigungWertFloat := Float (VerteidigungWert);
            
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
              VerteidigungWertFloat > Float (GlobaleDatentypen.ProduktionFeld'Last)
            then
               VerteidigungWert := GlobaleDatentypen.ProduktionFeld'Last;
               
            else
               VerteidigungWert := GlobaleDatentypen.ProduktionFeld (VerteidigungWertFloat);
            end if;
            
         when True =>
            null;
      end case;
      
      return VerteidigungWert;
      
   end AktuelleVerteidigungEinheit;
   
   
   
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
            AngriffWert := AngriffWert + GesamtwerteFeld.FeldAngriff (KoordinatenExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                                      RasseExtern       => EinheitRasseNummerExtern.Rasse);
            
            AngriffWertFloat := Float (AngriffWert);
            -- Diesen Bonus anders gestalten, vielleicht auf Basis der Bewegungspunkte?
            AngriffWertFloat := AngriffWertFloat * AngriffBonus;
            
            if
              AngriffWertFloat > Float (GlobaleDatentypen.ProduktionFeld'Last)
            then
               AngriffWert := GlobaleDatentypen.ProduktionFeld'Last;
               
            else
               AngriffWert := GlobaleDatentypen.ProduktionFeld (AngriffWertFloat);
            end if;
            
         when False =>
            null;
      end case;
     
      return AngriffWert;
   
   end AktuellerAngriffEinheit;

end KampfwerteEinheitErmitteln;
