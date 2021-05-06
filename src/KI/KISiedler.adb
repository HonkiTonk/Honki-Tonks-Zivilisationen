pragma SPARK_Mode (On);

with StadtBauen, KIBewegung, KIGefahr, KIEinheitVerbessernOderVernichten, StadtSuchen, EinheitSuchen, KarteneigenschaftSuchen;

package body KISiedler is

   procedure KISiedler
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      SicherheitsZähler := 1;
      
      Wichtigkeit := (others => 0);
      
      AufgabeErmittelnSchleife:
      while SicherheitsZähler < 1_000 loop
         
         Aufgabe := VorhandeneMöglichkeiten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
         case
           Aufgabe
         is
            when KIDatentypen.Keine_Aufgabe =>         
               null;
               
            when KIDatentypen.Stadt_Bauen =>
               StadtErfolgreichGebaut := StadtBauenPrüfung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
               if
                 StadtErfolgreichGebaut = True
               then
                  return;

               else
                  Aufgabe := KIDatentypen.Einheit_Bewegen;
               end if;
               
            when KIDatentypen.Einheit_Bewegen =>
               null;
               
            when KIDatentypen.Verbesserung_Anlegen =>
               null;
               
            when KIDatentypen.Einheit_Auflösen =>
               null;
               
            when KIDatentypen.Fliehen =>
               null;
               
            when others =>
               null;
         end case;         

         Gefahr := KIGefahr.KIGefahr (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         case
           Gefahr
         is
            when True =>
               KIBewegung.KIBewegung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                      AufgabeExtern            => KIDatentypen.Flucht);
               return;
                  
            when False =>
               null;
         end case;

         Verbessern := KIEinheitVerbessernOderVernichten.KIEinheitVerbessern (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         case
           Verbessern
         is
            when True =>
               null;
                  
            when False =>
               null;
         end case;

         Vernichten := KIEinheitVerbessernOderVernichten.KIEinheitVernichten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         case
           Vernichten
         is
            when True =>
               null;
                  
            when False =>
               null;
         end case;
         
         if
           GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBewegungspunkte <= 0.00
         then
            return;
            
         else
            SicherheitsZähler := SicherheitsZähler + 1;
         end if;
         
      end loop AufgabeErmittelnSchleife;
      
   end KISiedler;
   
   
   
   function VorhandeneMöglichkeiten
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return KIDatentypen.Einheit_Befehl_Ermitteln_Enum
   is begin
      
      GewählteMöglichkeit := 1;
      
      Wichtigkeit (1) := NeueStadtBauenGehen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      Wichtigkeit (2) := StadtUmgebungVerbessern (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      -- Wichtigkeit (3) := Einheit_Auflösen;
      -- Wichtigkeit (4) := Fliehen;
      -- Wichtigkeit (5) := Heilen;
      -- Wichtigkeit (6) := Festsetzen;
      -- Wichtigkeit (7) := Einheit_Verbessern;
      
      WichtigkeitSchleife:
      for WichtigkeitSchleifenwert in WichtigkeitArray'First .. WichtigkeitArray'Last - 1 loop
         
         if
           Wichtigkeit (WichtigkeitSchleifenwert) > Wichtigkeit (WichtigkeitSchleifenwert + 1)
         then
            GewählteMöglichkeit := WichtigkeitSchleifenwert;
            
         else
            null;
         end if;
         
      end loop WichtigkeitSchleife;
      
      return Keine_Aufgabe;
      
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
      
      VerbesserungStraße := KarteneigenschaftSuchen.KartenStraßeEinheitSuchen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      VerbesserungGebiet := KarteneigenschaftSuchen.KartenVerbesserungEinheitSuchen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      DurchEigeneStadtBelegt := KarteneigenschaftSuchen.KartenBelegterGrundEinheitAbgleich (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
   
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



   function StadtBauenPrüfung
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      KartenFeldbewertung := KarteneigenschaftSuchen.KartenFelderbewertungEinheitSuchen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      if
        KartenFeldbewertung >= 90
      then
         StadtBauenRückgabeWert := StadtBauen.StadtBauen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         return StadtBauenRückgabeWert;

      else
         return False;
      end if;
   
   end StadtBauenPrüfung;

end KISiedler;
