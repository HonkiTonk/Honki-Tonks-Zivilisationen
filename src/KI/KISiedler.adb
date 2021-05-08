pragma SPARK_Mode (On);

with KIDatentypen;

with EinheitenDatenbank;

with StadtBauen, KIEinheitVerbessernOderVernichten, StadtSuchen, EinheitSuchen, KarteneigenschaftVereinfachung, DatenbankVereinfachung, KIPruefungen, KIBewegung;

package body KISiedler is

   procedure KISiedler
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      if
        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigung /= GlobaleDatentypen.Keine
      then
         null;
         
      elsif
        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigung = GlobaleDatentypen.Keine
        and
          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten /= (0, 0, 0)
      then
         null;
         
      else
         SicherheitsZähler := 1;
      
         Wichtigkeit := (others => 0);
      
         AufgabeErmittelnSchleife:
         while SicherheitsZähler < 10 loop
         
            Aufgabe := VorhandeneMöglichkeiten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
            case
              GewählteMöglichkeit
            is
               when 1 => -- Stadt bauen
                  StadtErfolgreichGebaut := StadtBauenPrüfung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
                  if
                    StadtErfolgreichGebaut = True
                  then
                     return;
                     
                  else
                     KIBewegung.KIBewegungNeu (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
                  end if;
            
               when 2 => -- Stadtumgebung verbessern
                  null;
            
               when 3 => -- Einheit auflösen
                  KIEinheitVerbessernOderVernichten.KIEinheitVernichten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
               when 4 => -- Fliehen
                  null;
            
               when 5 => -- Sich heilen
                  null;
            
               when 6 => -- Sich befestigen
                  null;
            
               when 7 => -- Sich verbessern
                  KIEinheitVerbessernOderVernichten.KIEinheitVerbessern (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
               when others =>
                  return;
            end case;
            
            if
              GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition
              /= GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten
            then
               KIBewegung.KIBewegung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                      AufgabeExtern            => KIDatentypen.Keine_Aufgabe);
               
            else
               null;
            end if;
         
            if
              GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBewegungspunkte <= 0.00
            then
               return;
            
            else
               SicherheitsZähler := SicherheitsZähler + 1;
            end if;
         
         end loop AufgabeErmittelnSchleife;
      end if;
      
   end KISiedler;
   
   
   
   function VorhandeneMöglichkeiten
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Natural
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
      
      WichtigkeitSchleife:
      for WichtigkeitSchleifenwert in WichtigkeitArray'Range loop
         
         if
           Wichtigkeit (WichtigkeitSchleifenwert) > Wichtigkeit (GewählteMöglichkeit)
         then
            GewählteMöglichkeit := WichtigkeitSchleifenwert;
            
         else
            null;
         end if;
         
      end loop WichtigkeitSchleife;
      
      return GewählteMöglichkeit;
      
   end VorhandeneMöglichkeiten;
   


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
