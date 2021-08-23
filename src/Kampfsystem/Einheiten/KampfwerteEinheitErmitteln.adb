pragma SPARK_Mode (On);

with GlobaleKonstanten;

with StadtSuchen, GesamtwerteFeld, LeseEinheitenGebaut, LeseEinheitenDatenbank;

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
                                                                   RasseExtern       => EinheitRasseNummerExtern.Rasse) > GlobaleDatentypen.ProduktionFeld'Last
            then
               VerteidigungWert := GlobaleDatentypen.ProduktionFeld'Last;
               
            else
               VerteidigungWert := VerteidigungWert + GesamtwerteFeld.FeldVerteidigung (KoordinatenExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                                                        RasseExtern       => EinheitRasseNummerExtern.Rasse);
            end if;
            
            case
              LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
            is
               when GlobaleDatentypen.Verschanzen =>
                  if
                    Float (VerteidigungWert) * VerschanzungBonus > Float (GlobaleDatentypen.ProduktionFeld'Last)
                  then
                     VerteidigungWert := GlobaleDatentypen.ProduktionFeld'Last;
                     
                  else              
                     VerteidigungWert := GlobaleDatentypen.ProduktionFeld (Float (VerteidigungWert) * VerschanzungBonus);
                  end if;
                  
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
                  if
                    Float (VerteidigungWert) * StadtBonus > Float (GlobaleDatentypen.ProduktionFeld'Last)
                  then
                     VerteidigungWert := GlobaleDatentypen.ProduktionFeld'Last;
                     
                  else              
                     VerteidigungWert := GlobaleDatentypen.ProduktionFeld (Float (VerteidigungWert) * StadtBonus);
                  end if;
            end case;
              
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
            
            -- Diesen Bonus anders gestalten, vielleicht auf Basis der Bewegungspunkte?
            if
              Float (AngriffWert) * AngriffBonus > Float (GlobaleDatentypen.ProduktionFeld'Last)
            then
               AngriffWert := GlobaleDatentypen.ProduktionFeld'Last;
                 
            else              
               AngriffWert := GlobaleDatentypen.ProduktionFeld (Float (AngriffWert) * AngriffBonus);
            end if;
            
         when False =>
            null;
      end case;
     
      return AngriffWert;
   
   end AktuellerAngriffEinheit;

end KampfwerteEinheitErmitteln;
