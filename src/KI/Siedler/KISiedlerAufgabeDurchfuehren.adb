pragma SPARK_Mode (On);

with KIDatentypen;

with StadtBauen, KINullwerteSetzen, Verbesserungen, Karten;

package body KISiedlerAufgabeDurchfuehren is

   procedure SiedlerAufgabeDurchfuehren
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      case
        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBeschäftigt
      is
         when KIDatentypen.Stadt_Bauen =>
            StadtBauen.StadtBauen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            KINullwerteSetzen.ZielBewegungNullSetzen (EinheitRasseNummerExtern    => EinheitRasseNummerExtern,
                                                      WelchenWertNullSetzenExtern => 0);
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBeschäftigt := KIDatentypen.Keine_Aufgabe;
            
            
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
      
      case
        Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.EAchse,
                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.YAchse,
                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.XAchse).VerbesserungGebiet
      is
         when GlobaleDatentypen.Leer =>         
            Grund := Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.EAchse,
                                       GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.YAchse,
                                       GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.XAchse).Grund;
      
            if
              Grund = GlobaleDatentypen.Hügel 
              or
                Grund = GlobaleDatentypen.Gebirge
                or
                  Grund = GlobaleDatentypen.Kohle
                  or
                    Grund = GlobaleDatentypen.Eisen
                    or
                      Grund = GlobaleDatentypen.Gold
                      or
                        Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.EAchse,
                                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.YAchse,
                                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.XAchse).Hügel = True
            then
               Verbesserungen.Verbesserung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                            BefehlExtern             => GlobaleDatentypen.Mine_Bauen);
         
            elsif
              Grund = GlobaleDatentypen.Eis
            then
               Verbesserungen.Verbesserung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                            BefehlExtern             => GlobaleDatentypen.Festung_Bauen);
         
            else
               Verbesserungen.Verbesserung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                            BefehlExtern             => GlobaleDatentypen.Farm_Bauen);
            end if;
            
            return;
      
         when others =>
            null;
      end case;
      
      case
        Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.EAchse,
                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.YAchse,
                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.XAchse).VerbesserungWeg
      is
         when GlobaleDatentypen.Leer =>
            Verbesserungen.Verbesserung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                         BefehlExtern             => GlobaleDatentypen.Straße_Bauen);
            return;
            
         when others =>
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigung := GlobaleDatentypen.Nicht_Vorhanden;
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBeschäftigt := KIDatentypen.Keine_Aufgabe;
      end case;
      
   end WelcheVerbesserungAnlegen;

end KISiedlerAufgabeDurchfuehren;
