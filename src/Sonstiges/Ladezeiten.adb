pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Float_Text_IO;
use Ada.Wide_Wide_Text_IO;

with GlobaleTexte;

with Anzeige, Eingabe;

package body Ladezeiten is

   procedure LadezeitenSpielweltErstellen
     (WelcheZeitExtern : in Positive)
   is begin

      GesamtzeitSpielweltErstellen := 0.00;
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Ladezeiten,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => WelcheZeitExtern,
                                     LetzteZeileExtern      => WelcheZeitExtern,
                                     AbstandAnfangExtern    => GlobaleTexte.Leer,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      
      case
        WelcheZeitExtern
      is
         when 1 =>
            ZeitAuswahlSchleife:
            for VerschiedeneZeitenSchleifenwert in 2 .. SpielweltErstellenZeit'Last (1) loop                  
               
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
     (WelcheZeitExtern : in Positive)
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
     (WelcheZeitExtern : in Positive)
   is begin

      GesamtzeitKI := 0.00;
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Ladezeiten,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => WelcheZeitExtern + KIAufschlag,
                                     LetzteZeileExtern      => WelcheZeitExtern + KIAufschlag,
                                     AbstandAnfangExtern    => GlobaleTexte.Leer,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      
      case
        WelcheZeitExtern
      is
         when 19 =>
            ZeitAuswahlSchleife:
            for VerschiedeneZeitenSchleifenwert in KIZeiten'First (1) .. KIZeiten'Last (1) - 1 loop                  
               
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
