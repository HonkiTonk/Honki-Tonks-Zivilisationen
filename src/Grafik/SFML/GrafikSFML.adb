pragma SPARK_Mode (On);

with SystemDatentypen; use SystemDatentypen;
with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with StadtKonstanten;

with Fehler;
with GrafikStartEnde;
with Intro;
with AuswahlMenueAnzeige;
with Karte;
with InteraktionTasks;
with KarteStadt;
with InDerStadt;
with GrafikAllgemein;
with Sichtweiten;
with ForschungAnzeigeSFML;

package body GrafikSFML is
   
   procedure GrafikSFML
   is begin
      
      GrafikStartEnde.FensterErzeugen;

      GrafikSchleife:
      loop
         
         case
           InteraktionTasks.FensterVerändert
         is
            when True =>
               GrafikAllgemein.FensterAnpassen;
               Sichtweiten.SichtweiteBewegungsfeldFestlegen;
               InteraktionTasks.FensterVerändert := False;
               
            when False =>
               null;
         end case;
         
         GrafikStartEnde.FensterLeeren;
         
         -- Die Auswahl in eine eigene Funktion auslagern?
         case
           InteraktionTasks.AktuelleDarstellung
         is
            when SystemDatentypen.Konsole_Start =>
               -- Aber wie wechselt man dann von der Konsole auf die Grafik? Nur per Neustart?
               Fehler.GrafikStopp (FehlermeldungExtern => "GrafikSFML.GrafikSFML - Konsole wird bei SFML aufgerufen.");
            
            when SystemDatentypen.SFML_Start =>
               InteraktionTasks.FensterErzeugt := True;
               InteraktionTasks.AktuelleDarstellung := SystemDatentypen.Grafik_Pause;
               
            when SystemDatentypen.Grafik_Intro =>
               Intro.Intro;
               InteraktionTasks.AktuelleDarstellung := SystemDatentypen.Grafik_Pause;
                              
            when SystemDatentypen.Grafik_Pause =>
               delay InteraktionTasks.WartezeitGrafik;
         
            when SystemDatentypen.Grafik_Menüs =>
               AuswahlMenueAnzeige.AnzeigeSFMLAnfang;
               
            when SystemDatentypen.Grafik_Weltkarte =>
               if
                 InteraktionTasks.AktuelleRasse = SystemDatentypen.Keine_Rasse
               then
                  delay InteraktionTasks.WartezeitGrafik;
                     
               else
                  Karte.AnzeigeKarte (RasseExtern => InteraktionTasks.AktuelleRasse);
               end if;
               
            when SystemDatentypen.Grafik_Stadtkarte =>
               if
                 InDerStadt.AktuelleRasseStadt.Platznummer = StadtKonstanten.LeerNummer
               then
                  delay InteraktionTasks.WartezeitGrafik;
                  
               else
                  KarteStadt.AnzeigeStadt (StadtRasseNummerExtern => InDerStadt.AktuelleRasseStadt);
               end if;
               
            when SystemDatentypen.Grafik_Forschung =>
               if
                 InteraktionTasks.AktuelleRasse = SystemDatentypen.Keine_Rasse
               then
                  -- Da die Rasse schon auf der Weltkarte festgelegt wird, sollte dieser Fall niemals eintreten können. Beachten dass die Rasse zwischen den Zügen notwendig aber nicht festgelegt ist.
                  Fehler.GrafikStopp (FehlermeldungExtern => "GrafikSFML.GrafikSFML - Forschungsmenü wird ohen Rasse aufgerufen.");
                     
               else
                  ForschungAnzeigeSFML.ForschungAnzeige;
               end if;
         
            when SystemDatentypen.Grafik_Ende =>
               exit GrafikSchleife;
         end case;
      
         GrafikStartEnde.FensterAnzeigen;
         
      end loop GrafikSchleife;
      
      GrafikStartEnde.FensterEntfernen;
      
   end GrafikSFML;

end GrafikSFML;
