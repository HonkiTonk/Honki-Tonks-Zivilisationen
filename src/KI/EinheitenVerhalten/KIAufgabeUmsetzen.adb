pragma SPARK_Mode (On);

with LeseKarten, LeseEinheitenGebaut;

with Verbesserungen;

package body KIAufgabeUmsetzen is
   
   function WelcheVerbesserungAnlegen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      case
        LeseKarten.VerbesserungGebiet (PositionExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
      is
         when GlobaleDatentypen.Leer =>         
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
        LeseKarten.VerbesserungWeg (PositionExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
      is
         when GlobaleDatentypen.Leer =>
            return Verbesserungen.VerbesserungAnlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                       BefehlExtern             => GlobaleDatentypen.Straße_Bauen);
            
         when others =>
            null;
      end case;
      
      return False;
      
   end WelcheVerbesserungAnlegen;
   
   
   
   function VerbesserungGebiet
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      Grund := LeseKarten.Grund (PositionExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
         
      if
        (Grund = GlobaleDatentypen.Hügel 
         or
           Grund = GlobaleDatentypen.Gebirge
         or
           Grund = GlobaleDatentypen.Kohle
         or
           Grund = GlobaleDatentypen.Eisen
         or
           Grund = GlobaleDatentypen.Gold
         or
           LeseKarten.Hügel (PositionExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) = True)
        and
          Verbesserungen.VerbesserungTesten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                             BefehlExtern             => GlobaleDatentypen.Mine_Bauen)
        = True
      then
         Befehl := GlobaleDatentypen.Mine_Bauen;
         
      elsif
        Grund = GlobaleDatentypen.Eis
        and
          Verbesserungen.VerbesserungTesten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                             BefehlExtern             => GlobaleDatentypen.Festung_Bauen)
        = True
      then
         Befehl := GlobaleDatentypen.Festung_Bauen;
         
      elsif
        Verbesserungen.VerbesserungTesten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                           BefehlExtern             => GlobaleDatentypen.Farm_Bauen)
        = True
      then
         Befehl := GlobaleDatentypen.Farm_Bauen;
            
      else
         return False;
      end if;
      
      return Verbesserungen.VerbesserungAnlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                 BefehlExtern             => Befehl);
      
   end VerbesserungGebiet;
      
      

   function EinheitVerbessern
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      NullWert := Verbesserungen.VerbesserungAnlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                      BefehlExtern             => GlobaleDatentypen.Einheit_Verbessern);
      
      return False;
      
   end EinheitVerbessern;

end KIAufgabeUmsetzen;
