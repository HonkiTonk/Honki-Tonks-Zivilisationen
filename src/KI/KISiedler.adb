pragma SPARK_Mode (On);

with Karten, StadtWerteFestlegen, StadtBauen, KIBewegung, KIGefahr, KIEinheitVerbessernOderVernichten, StadtSuchen, EinheitSuchen;

package body KISiedler is

   procedure KISiedler
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      Aufgabe := Anfang;
      SicherheitsZähler := 0;
      
      AufgabeErmittelnSchleife:
      while SicherheitsZähler < 10_000 loop
         
         case
           Aufgabe
         is
            when KIDatentypen.Anfang =>         
               Aufgabe := NeueStadtBauenGehen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
               
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
               
            when KIDatentypen.Verbesserung =>
               null;
               
            when KIDatentypen.Einheit_Auflösen =>
               null;
               
            when KIDatentypen.Fliehen =>
               null;
               
            when KIDatentypen.Fertig =>
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

         UmgebungVerbessern := StadtUmgebungVerbessern (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         case
           UmgebungVerbessern
         is
         when True =>
            null;
                  
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
      
         BewegungsSchleife:
         loop
         
            KIBewegung.KIBewegung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                   AufgabeExtern            => KIDatentypen.Stadt_Bauen);
         
            if
              GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBewegungspunkte <= 0.00
            then
               exit BewegungsSchleife;
            
            else
               null;
            end if;
         
         end loop BewegungsSchleife;
         
         if
           GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBewegungspunkte <= 0.00
         then
            return;
            
         else
            SicherheitsZähler := SicherheitsZähler + 1;
         end if;
         
      end loop AufgabeErmittelnSchleife;
      
   end KISiedler;
   


   function NeueStadtBauenGehen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return KIDatentypen.Einheit_Befehl_Ermitteln_Enum
   is begin
      
      VorhandeneStädte := StadtSuchen.AnzahlStädteErmitteln (RasseExtern => EinheitRasseNummerExtern.Rasse);
      VorhandeneSiedler := EinheitSuchen.MengeEinesEinheitenTypsSuchen (RasseExtern      => EinheitRasseNummerExtern.Rasse,
                                                                        EinheitTypExtern => 1);
      
      if
        VorhandeneStädte = 0
      then
         GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBeschäftigt := KIDatentypen.Stadt_Bauen;
         return KIDatentypen.Stadt_Bauen;
         
      elsif
        VorhandeneSiedler < VorhandeneStädte * 2 - VorhandeneSiedler
      then
         GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBeschäftigt := KIDatentypen.Stadt_Bauen;
         return KIDatentypen.Stadt_Bauen;
         
      else
         null;
      end if;
      
      return KIDatentypen.Verbesserung;
      
   end NeueStadtBauenGehen;



   function StadtUmgebungVerbessern
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Boolean
   is begin
   
      if
        Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).DurchStadtBelegterGrund
      in
        GlobaleDatentypen.BelegterGrund (EinheitRasseNummerExtern.Rasse) * StadtWerteFestlegen.RassenMulitplikationWert .. GlobaleDatentypen.BelegterGrund (EinheitRasseNummerExtern.Rasse)
        * StadtWerteFestlegen.RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (GlobaleVariablen.StadtGebaut'Last (2))
        and
          (Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                             GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                             GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).VerbesserungStraße = 0
           or
             Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).VerbesserungGebiet = 0)
      then
         return True;
            
      else
         return False;
      end if;      
            
   end StadtUmgebungVerbessern;



   function StadtBauenPrüfung
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      if
        Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).Felderwertung >= 90
      then
         StadtBauenRückgabeWert := StadtBauen.StadtBauen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         return StadtBauenRückgabeWert;

      else
         return False;
      end if;
   
   end StadtBauenPrüfung;

end KISiedler;
