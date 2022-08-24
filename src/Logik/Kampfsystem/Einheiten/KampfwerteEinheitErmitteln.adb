pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenDatentypen; use EinheitenDatentypen;
with KampfDatentypen; use KampfDatentypen;
with StadtKonstanten;
with AufgabenDatentypen;
with ProduktionDatentypen;

with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;

with StadtSuchen;
with GesamtwerteFeld;

package body KampfwerteEinheitErmitteln is

   -- Mit_Hügel noch berücksichtigen
   function AktuelleVerteidigungEinheit
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      AngreiferExtern : in Boolean)
      return KampfDatentypen.Kampfwerte
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
        VerteidigungWert + Bonus > KampfDatentypen.Kampfwerte'Last
      then
         return KampfDatentypen.Kampfwerte'Last;
         
      else
         return VerteidigungWert + Bonus;
      end if;
      
   end AktuelleVerteidigungEinheit;
   
   
   
   function VerteidigungsbonusVerteidiger
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KampfDatentypen.Kampfwerte
   is begin
      
      VerteidigungWertFloat := Float (GesamtwerteFeld.FeldVerteidigung (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                                        RasseExtern       => EinheitRasseNummerExtern.Rasse));
      
      case
        LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
      is
         when AufgabenDatentypen.Verschanzen_Enum =>
            VerteidigungWertFloat := VerteidigungWertFloat * VerschanzungBonus;
                  
         when others =>
            null;
      end case;
            
      case
        StadtSuchen.KoordinatenStadtMitRasseSuchen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                    KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
      is
         when StadtKonstanten.LeerNummer =>
            null;
                  
         when others =>
            VerteidigungWertFloat := VerteidigungWertFloat * StadtBonus;
      end case;
              
      if
        VerteidigungWertFloat > Float (ProduktionDatentypen.Stadtproduktion'Last)
      then
         return KampfDatentypen.Kampfwerte'Last;
               
      else
         return KampfDatentypen.Kampfwerte (VerteidigungWertFloat);
      end if;
      
   end VerteidigungsbonusVerteidiger;
   
   
   
   function VerteidigungsbonusAngreifer
     return KampfDatentypen.Kampfwerte
   is begin
      
      return 0;
      
   end VerteidigungsbonusAngreifer;
   
   
   
   function AktuellerAngriffEinheit
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      AngreiferExtern : in Boolean)
      return KampfDatentypen.Kampfwerte
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
        AngriffWert + Bonus > KampfDatentypen.Kampfwerte'Last
      then
         return KampfDatentypen.Kampfwerte'Last;
         
      else
         return AngriffWert + Bonus;
      end if;
   
   end AktuellerAngriffEinheit;
   
   
   
   function AngriffsbonusAngreifer
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KampfDatentypen.Kampfwerte
   is begin
      
      AngriffWertFloat := Float (GesamtwerteFeld.FeldAngriff (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                              RasseExtern       => EinheitRasseNummerExtern.Rasse));
            
      -- Diesen Bonus anders gestalten, vielleicht auf Basis der Bewegungspunkte?
      AngriffWertFloat := AngriffWertFloat * AngriffBonus;
            
      if
        AngriffWertFloat > Float (ProduktionDatentypen.Feldproduktion'Last)
      then
         return KampfDatentypen.Kampfwerte'Last;
               
      else
         return KampfDatentypen.Kampfwerte (AngriffWertFloat);
      end if;
      
   end AngriffsbonusAngreifer;
   
   
   
   function AngriffsbonusVerteidiger
     return KampfDatentypen.Kampfwerte
   is begin
      
      return 0;
      
   end AngriffsbonusVerteidiger;

end KampfwerteEinheitErmitteln;
