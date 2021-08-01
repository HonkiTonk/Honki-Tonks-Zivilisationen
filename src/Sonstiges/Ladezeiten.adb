pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Float_Text_IO;
use Ada.Wide_Wide_Text_IO;

with GlobaleTexte;

with Anzeige, Eingabe;

package body Ladezeiten is

   procedure LadezeitenSpielweltErstellen
     (WelcheZeitExtern : in Spielwelt_Erstellen_Zeit_Verwendet_Enum)
   is begin

      GesamtzeitSpielweltErstellen := 0.00;
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Ladezeiten,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => Spielwelt_Erstellen_Zeit_Verwendet_Enum'Pos (WelcheZeitExtern),
                                     LetzteZeileExtern      => Spielwelt_Erstellen_Zeit_Verwendet_Enum'Pos (WelcheZeitExtern),
                                     AbstandAnfangExtern    => GlobaleTexte.Leer,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      
      case
        WelcheZeitExtern
      is
         when Gesamtzeit =>
            ZeitAuswahlSchleife:
            for VerschiedeneZeitenSchleifenwert in Gesamtzeit_Enum'Range loop                  
               
               GesamtzeitSpielweltErstellen := GesamtzeitSpielweltErstellen + Float (SpielweltErstellenZeit (VerschiedeneZeitenSchleifenwert, GlobaleDatentypen.Endwert)
                                                                                     - SpielweltErstellenZeit (VerschiedeneZeitenSchleifenwert, GlobaleDatentypen.Anfangswert));
                  
            end loop ZeitAuswahlSchleife;
            Ada.Float_Text_IO.Put (Item => GesamtzeitSpielweltErstellen,
                                   Fore => 1,
                                   Aft  => 6,
                                   Exp  => 0);
            Eingabe.WartenEingabe;
            
         when others =>
            Ada.Float_Text_IO.Put (Item => Float (SpielweltErstellenZeit (WelcheZeitExtern, GlobaleDatentypen.Endwert) - SpielweltErstellenZeit (WelcheZeitExtern, GlobaleDatentypen.Anfangswert)),
                                   Fore => 1,
                                   Aft  => 6,
                                   Exp  => 0);
            New_Line;
      end case;
                  
   end LadezeitenSpielweltErstellen;
   
   
   
   procedure AnzeigeEinzelneZeit
     (WelcheZeitExtern : in Einzelne_Zeiten_Enum)
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Ladezeiten,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => Aufschlag (WelcheZeitExtern),
                                     LetzteZeileExtern      => Aufschlag (WelcheZeitExtern),
                                     AbstandAnfangExtern    => GlobaleTexte.Leer,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      
      Ada.Float_Text_IO.Put (Item => Float (EinzelneZeiten (WelcheZeitExtern, GlobaleDatentypen.Endwert) - EinzelneZeiten (WelcheZeitExtern, GlobaleDatentypen.Anfangswert)),
                             Fore => 1,
                             Aft  => 6,
                             Exp  => 0);
      Eingabe.WartenEingabe;
      
   end AnzeigeEinzelneZeit;
   
   
   
   procedure AnzeigeKIZeit
     (WelcheZeitExtern : in GlobaleDatentypen.Rassen_Enum)
   is begin

      GesamtzeitKI := 0.00;
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Ladezeiten,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => KIText (WelcheZeitExtern),
                                     LetzteZeileExtern      => KIText (WelcheZeitExtern),
                                     AbstandAnfangExtern    => GlobaleTexte.Leer,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      
      case
        WelcheZeitExtern
      is
         when GlobaleDatentypen.Leer =>
            ZeitAuswahlSchleife:
            for VerschiedeneZeitenSchleifenwert in GlobaleDatentypen.Rassen_Verwendet_Enum'Range loop                  
               
               GesamtzeitKI := GesamtzeitKI + Float (KIZeiten (VerschiedeneZeitenSchleifenwert, GlobaleDatentypen.Endwert) - KIZeiten (VerschiedeneZeitenSchleifenwert, GlobaleDatentypen.Anfangswert));
                  
            end loop ZeitAuswahlSchleife;
            Ada.Float_Text_IO.Put (Item => GesamtzeitKI,
                                   Fore => 1,
                                   Aft  => 6,
                                   Exp  => 0);
            New_Line;
            
         when others =>
            Ada.Float_Text_IO.Put (Item => Float (KIZeiten (WelcheZeitExtern, GlobaleDatentypen.Endwert) - KIZeiten (WelcheZeitExtern, GlobaleDatentypen.Anfangswert)),
                                   Fore => 1,
                                   Aft  => 6,
                                   Exp  => 0);
            New_Line;
      end case;
      
   end AnzeigeKIZeit;

end Ladezeiten;
