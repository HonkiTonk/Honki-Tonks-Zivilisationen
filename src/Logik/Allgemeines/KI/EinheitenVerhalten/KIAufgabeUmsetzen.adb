pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartengrundDatentypen; use KartengrundDatentypen;
with KartenVerbesserungDatentypen;

with LeseKarten;
with LeseEinheitenGebaut;

with Aufgaben;

package body KIAufgabeUmsetzen is
   
   function WelcheVerbesserungAnlegen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      case
        LeseKarten.Verbesserung (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
      is
         when KartenVerbesserungDatentypen.Leer_Verbesserung_Enum =>
            if
              VerbesserungGebiet (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = True
            then
               return True;
               
            else
               null;
            end if;
      
         when others =>
            null;
      end case;
      
      case
        LeseKarten.Weg (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
      is
         when KartenVerbesserungDatentypen.Leer_Weg_Enum =>
            return Aufgaben.VerbesserungAnlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                 BefehlExtern             => TastenbelegungDatentypen.Straße_Bauen_Enum);
            
         when others =>
            null;
      end case;
      
      return False;
      
   end WelcheVerbesserungAnlegen;
   
   
   
   function VerbesserungGebiet
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      EinheitKoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      Grund := LeseKarten.Grund (KoordinatenExtern => EinheitKoordinaten);
      Ressourcen := LeseKarten.Ressource (KoordinatenExtern => EinheitKoordinaten);
         
      if
        (Grund = KartengrundDatentypen.Hügel_Enum
         or
           Grund = KartengrundDatentypen.Gebirge_Enum
         or
           Ressourcen = KartengrundDatentypen.Kohle_Enum
         or
           Ressourcen = KartengrundDatentypen.Eisen_Enum
         or
           Ressourcen = KartengrundDatentypen.Gold_Enum
         or
           LeseKarten.Hügel (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) = True)
        and
          Aufgaben.VerbesserungTesten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                       BefehlExtern             => TastenbelegungDatentypen.Mine_Bauen_Enum)
        = True
      then
         Befehl := TastenbelegungDatentypen.Mine_Bauen_Enum;
         
      elsif
        Grund = KartengrundDatentypen.Eis_Enum
        and
          Aufgaben.VerbesserungTesten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                       BefehlExtern             => TastenbelegungDatentypen.Festung_Bauen_Enum)
        = True
      then
         Befehl := TastenbelegungDatentypen.Festung_Bauen_Enum;
         
      elsif
        Aufgaben.VerbesserungTesten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                     BefehlExtern             => TastenbelegungDatentypen.Farm_Bauen_Enum)
        = True
      then
         Befehl := TastenbelegungDatentypen.Farm_Bauen_Enum;
            
      else
         return False;
      end if;
      
      return Aufgaben.VerbesserungAnlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                           BefehlExtern             => Befehl);
      
   end VerbesserungGebiet;
      
      

   function EinheitVerbessern
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      NullWert := Aufgaben.VerbesserungAnlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                BefehlExtern             => TastenbelegungDatentypen.Einheit_Verbessern_Enum);
      
      return False;
      
   end EinheitVerbessern;

end KIAufgabeUmsetzen;
