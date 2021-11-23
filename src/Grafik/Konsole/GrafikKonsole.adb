pragma SPARK_Mode (On);

with SystemDatentypen;

with GrafikWichtigeEinstellungen;
with Intro;
with ImSpiel;
with Fehler;
with Karte;

package body GrafikKonsole is

   procedure GrafikKonsole
   is begin
            
      GrafikSchleife:
      loop
                  
         case
           GrafikWichtigeEinstellungen.AktuelleDarstellung
         is
            when SystemDatentypen.Konsole_Start =>
               GrafikWichtigeEinstellungen.FensterErzeugt := True;
               GrafikWichtigeEinstellungen.AktuelleDarstellung := SystemDatentypen.Grafik_Pause;
            
            when SystemDatentypen.SFML_Start =>
               -- Aber wie wechselt man dann von der Konsole auf die Grafik? Nur per Neustart?
               Fehler.GrafikStopp (FehlermeldungExtern => "SFMLDarstellungAuswahl.SFMLDarstellungAuswahl - Konsole wird bei SFML aufgerufen.");
               
            when SystemDatentypen.Grafik_Intro =>
               Intro.Intro;
               GrafikWichtigeEinstellungen.AktuelleDarstellung := SystemDatentypen.Grafik_Pause;
                              
            when SystemDatentypen.Grafik_Pause =>
               delay GrafikWichtigeEinstellungen.Wartezeit;
         
            when SystemDatentypen.Grafik_Menüs =>
               -- AuswahlMenueAnzeige.AnzeigeSFMLAnfang;
               GrafikWichtigeEinstellungen.AktuelleDarstellung := SystemDatentypen.Grafik_Pause;
               
            when SystemDatentypen.Grafik_Eingabe =>
               null;
               
            when SystemDatentypen.Grafik_Weltkarte =>
               case
                 ImSpiel.AktuelleRasse
               is
                  when SystemDatentypen.Keine_Rasse =>
                     delay GrafikWichtigeEinstellungen.Wartezeit;
                     
                  when others =>
                     Karte.AnzeigeKarte (RasseExtern => ImSpiel.AktuelleRasse);
                     GrafikWichtigeEinstellungen.AktuelleDarstellung := SystemDatentypen.Grafik_Pause;
               end case;
               
            when SystemDatentypen.Grafik_Stadtkarte =>
               GrafikWichtigeEinstellungen.AktuelleDarstellung := SystemDatentypen.Grafik_Pause;
         
            when SystemDatentypen.Grafik_Ende =>
               exit GrafikSchleife;
         end case;
               
      end loop GrafikSchleife;
      
   end GrafikKonsole;

end GrafikKonsole;
