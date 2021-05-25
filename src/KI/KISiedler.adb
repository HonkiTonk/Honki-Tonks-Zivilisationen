pragma SPARK_Mode (On);

with KIDatentypen;
use KIDatentypen;

with EinheitenDatenbank;

with StadtBauen, StadtSuchen, EinheitSuchen, KarteneigenschaftVereinfachung, DatenbankVereinfachung, KIPruefungen, KIBewegungDurchfuehren, KIBewegungBerechnen;

package body KISiedler is

   procedure KISiedler
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      AktivitätSchleife:
      loop
         
         if
           GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten /= (0, 0, 0)
         then
            KIBewegungDurchfuehren.KIBewegungNeu (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
         elsif
           GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigung = GlobaleDatentypen.Keine
           and
             GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBeschäftigt = KIDatentypen.Keine_Aufgabe
         then
            AufgabeErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
         else
            null;
         end if;
      
         if
           GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBewegungspunkte > 0.00
           and
             GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID > 0
           and
             (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBeschäftigt /= KIDatentypen.Keine_Aufgabe
              or
                GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigung /= GlobaleDatentypen.Keine)
         then
            AufgabeDurchführen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
         else
            return;
         end if;
         
      end loop AktivitätSchleife;
      
   end KISiedler;
   
   
   
   procedure AufgabeErmitteln
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      GewählteMöglichkeit := 0;
      
      Wichtigkeit (0) := NichtsTun (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      Wichtigkeit (1) := NeueStadtBauenGehen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      Wichtigkeit (2) := StadtUmgebungVerbessern (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      Wichtigkeit (3) := EinheitAuflösen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      Wichtigkeit (4) := Fliehen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      Wichtigkeit (5) := SichHeilen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      Wichtigkeit (6) := SichBefestigen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      Wichtigkeit (7) := SichVerbessern (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      WichtigkeitEinsSchleife:
      for WichtigkeitEinsSchleifenwert in WichtigkeitArray'Range loop
         WichtigkeitZweiSchleife:
         for WichtigkeitZweiSchleifenwert in WichtigkeitArray'Range loop
         
            if
              Wichtigkeit (WichtigkeitEinsSchleifenwert) > Wichtigkeit (WichtigkeitZweiSchleifenwert)
              and
                Wichtigkeit (GewählteMöglichkeit) < Wichtigkeit (WichtigkeitEinsSchleifenwert)
            then
               GewählteMöglichkeit := WichtigkeitEinsSchleifenwert;
               
            elsif
              Wichtigkeit (WichtigkeitEinsSchleifenwert) < Wichtigkeit (WichtigkeitZweiSchleifenwert)
              and
                Wichtigkeit (GewählteMöglichkeit) < Wichtigkeit (WichtigkeitZweiSchleifenwert)
            then
               GewählteMöglichkeit := WichtigkeitZweiSchleifenwert;
               exit WichtigkeitZweiSchleife;
            
            else
               null;
            end if;
         
         end loop WichtigkeitZweiSchleife;
      end loop WichtigkeitEinsSchleife;
      
      case
        GewählteMöglichkeit
      is
         when 1 => -- Stadt bauen
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBeschäftigt := KIDatentypen.Stadt_Bauen;
            
         when 2 => -- Stadtumgebung verbessern
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBeschäftigt := KIDatentypen.Verbesserung_Anlegen;
            
         when 3 => -- Einheit auflösen
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBeschäftigt := KIDatentypen.Einheit_Auflösen;
            
         when 4 => -- Fliehen
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBeschäftigt := KIDatentypen.Flucht;
            
         when 5 => -- Sich heilen
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBeschäftigt := KIDatentypen.Einheit_Heilen;
            
         when 6 => -- Sich befestigen
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBeschäftigt := KIDatentypen.Einheit_Festsetzen;
            
         when 7 => -- Sich verbessern
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBeschäftigt := KIDatentypen.Einheit_Verbessern;
            
         when others => -- Nichts tun
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBeschäftigt := KIDatentypen.Keine_Aufgabe;
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigung := GlobaleDatentypen.Keine;
      end case;
      
   end AufgabeErmitteln;
   
   
   
   procedure AufgabeDurchführen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      null;
      
   end AufgabeDurchführen;
   


   function NeueStadtBauenGehen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Natural
   is begin
      
      VorhandeneStädte := StadtSuchen.AnzahlStädteErmitteln (RasseExtern => EinheitRasseNummerExtern.Rasse);
      VorhandeneSiedler := EinheitSuchen.MengeEinesEinheitenTypsSuchen (RasseExtern      => EinheitRasseNummerExtern.Rasse,
                                                                        EinheitTypExtern => 1);
      
      if
        VorhandeneStädte = 0
      then
         GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBeschäftigt := KIDatentypen.Stadt_Bauen;
         return 10;
         
      elsif
        VorhandeneSiedler < VorhandeneStädte * 2 - VorhandeneSiedler
      then
         GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBeschäftigt := KIDatentypen.Stadt_Bauen;
         return 5;
         
      else
         null;
      end if;
      
      return 0;
      
   end NeueStadtBauenGehen;



   function StadtUmgebungVerbessern
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Natural
   is begin
      
      VerbesserungStraße := KarteneigenschaftVereinfachung.KartenStraßeVereinfachung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      VerbesserungGebiet := KarteneigenschaftVereinfachung.KartenVerbesserungVereinfachung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      DurchEigeneStadtBelegt := KarteneigenschaftVereinfachung.KartenBelegterGrundAbgleich (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
   
      if
        DurchEigeneStadtBelegt = True        
        and
          (VerbesserungStraße = 0
           or
             VerbesserungGebiet = 0)
      then
         return 5;
            
      else
         return 0;
      end if;      
            
   end StadtUmgebungVerbessern;
                                    
                                    
                                    
   function EinheitAuflösen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Natural
   is begin
                                    
      return 0;
                                    
   end EinheitAuflösen;
                                    
                                    
                                    
   function Fliehen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Natural
   is begin
                                    
      return 0;
                                    
   end Fliehen;
   
   
   
   function SichHeilen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Natural
   is begin
      
      EinheitID := DatenbankVereinfachung.EinheitenIDVereinfachung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      if
        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleLebenspunkte
        = EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, EinheitID).MaximaleLebenspunkte
      then
         return 0;
         
      elsif
        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleLebenspunkte
        > EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, EinheitID).MaximaleLebenspunkte / 3 * 2
      then
         return 3;
         
      elsif
        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleLebenspunkte
        > EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, EinheitID).MaximaleLebenspunkte / 2
      then
         return 5;
         
      elsif
        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleLebenspunkte = 1
      then
         return 10;
         
      else
         return 8;
      end if;
      
   end SichHeilen;
   
   
   
   function SichBefestigen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Natural
   is begin
      
      return 0;
      
   end SichBefestigen;
   
   
   
   function SichVerbessern
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Natural
   is begin
      
      return 0;
      
   end SichVerbessern;
   
   
   
   function NichtsTun
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Natural
   is begin
      
      return 1;
      
   end NichtsTun;
   


   function StadtBauenPrüfung
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      if -- Später Rassen/Technolgie/Sonstigesabhängig die Mindestbewertung ermitteln
        EinheitRasseNummerExtern.Rasse in 1 .. 5
      then
         MindestBewertungKartenfeld := 90;
            
      else
         MindestBewertungKartenfeld := 90;
      end if;
      
      NeueStadtPosition := KIPruefungen.UmgebungStadtBauenPrüfen (EinheitRasseNummerExtern   => EinheitRasseNummerExtern,
                                                                   MindestBewertungFeldExtern => MindestBewertungKartenfeld);
      
      if
        NeueStadtPosition = (0, 0, 0, True)
      then
         StadtBauen.StadtBauen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         return True;
         
      elsif -- Wenn die YAchse /= 0 ist, dann ist auch die XAchse /= 0, keine weitere Prüfung nötig
        NeueStadtPosition.YAchse /= 0
      then
         GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten := (NeueStadtPosition.EAchse, NeueStadtPosition.YAchse, NeueStadtPosition.XAchse);
         GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBeschäftigt := KIDatentypen.Stadt_Bauen;
         return True;
         
      else
         null;
      end if;
      
      return False;
   
   end StadtBauenPrüfung;

end KISiedler;
