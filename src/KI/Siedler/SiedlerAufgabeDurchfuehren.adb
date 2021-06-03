pragma SPARK_Mode (On);

with KIDatentypen, KIKonstanten;

with StadtBauen, KINullwerteSetzen, Verbesserungen, KarteneigenschaftVereinfachung, Karten;

package body SiedlerAufgabeDurchfuehren is

   procedure SiedlerAufgabeDurchfuehren
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      case
        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBeschäftigt
      is
         when KIDatentypen.Stadt_Bauen =>
            if 
              GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten
              = GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition
              or
                GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten = KIKonstanten.NullKoordinate
            then
               StadtBauen.StadtBauen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
               KINullwerteSetzen.ZielBewegungNullSetzen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                         WelchenWertNullSetzten   => 0);
            
            else
               null;
            end if;
            
         when KIDatentypen.Verbesserung_Anlegen =>
            WelcheVerbesserungAnlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Flucht =>
            null;
            
         when KIDatentypen.Einheit_Heilen =>
            Verbesserungen.Verbesserung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                         BefehlExtern             => GlobaleDatentypen.Heilen);
            
         when KIDatentypen.Einheit_Festsetzen =>
            Verbesserungen.Verbesserung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                         BefehlExtern             => GlobaleDatentypen.Verschanzen);
            
         when KIDatentypen.Einheit_Verbessern =>
            null;
            
         when others =>
            null;
      end case;
      
   end SiedlerAufgabeDurchfuehren;
   
   
   
   procedure WelcheVerbesserungAnlegen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      if
        Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).VerbesserungStraße in 5 .. 19
      then
         Grund := KarteneigenschaftVereinfachung.KartenGrundVereinfachung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
         if
           Grund in 6 .. 7
           or
             Grund in 10 .. 11
             or
               Grund = 33
               or
                 KarteneigenschaftVereinfachung.KartenHügelVereinfachung (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = True
         then
            Verbesserungen.Verbesserung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                         BefehlExtern             => GlobaleDatentypen.Mine_Bauen);
         
         elsif
           Grund = 1
         then
            Verbesserungen.Verbesserung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                         BefehlExtern             => GlobaleDatentypen.Festung_Bauen);
         
         else
            Verbesserungen.Verbesserung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                         BefehlExtern             => GlobaleDatentypen.Farm_Bauen);
         end if;
         
      elsif
        Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).VerbesserungGebiet >= 20
      then         
         GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigung := GlobaleDatentypen.Keine;
         GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBeschäftigt := KIDatentypen.Keine_Aufgabe;
            
      else
         Verbesserungen.Verbesserung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                      BefehlExtern             => GlobaleDatentypen.Straße_Bauen);
         
      end if;
      
   end WelcheVerbesserungAnlegen;

end SiedlerAufgabeDurchfuehren;
