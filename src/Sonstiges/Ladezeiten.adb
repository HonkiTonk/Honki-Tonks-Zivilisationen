pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Float_Text_IO;
use Ada.Wide_Wide_Text_IO;

with GlobaleDatentypen;

with Anzeige, Eingabe;

package body Ladezeiten is

   procedure LadezeitenSpielweltErstellen
     (WelcheZeitExtern : in Positive)
   is begin

      GesamtzeitSpielweltErstellen := 0.00;
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                     TextDateiExtern        => GlobaleDatentypen.Ladezeiten,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => WelcheZeitExtern,
                                     LetzteZeileExtern      => WelcheZeitExtern,
                                     AbstandAnfangExtern    => GlobaleDatentypen.Keiner,
                                     AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                     AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);
      
      case
        WelcheZeitExtern
      is
         when 1 =>
            ZeitAuswahlSchleife:
            for VerschiedeneZeitenSchleifenwert in 2 .. SpielweltErstellenZeit'Last (1) loop                  
               
               GesamtzeitSpielweltErstellen := GesamtzeitSpielweltErstellen + Float (SpielweltErstellenZeit (VerschiedeneZeitenSchleifenwert, 2) - SpielweltErstellenZeit (VerschiedeneZeitenSchleifenwert, 1));
                  
            end loop ZeitAuswahlSchleife;
            Ada.Float_Text_IO.Put (Item => GesamtzeitSpielweltErstellen,
                                   Fore => 1,
                                   Aft  => 6,
                                   Exp  => 0);
            Eingabe.WartenEingabe;
            
         when others =>
            Ada.Float_Text_IO.Put (Item => Float (SpielweltErstellenZeit (WelcheZeitExtern, 2) - SpielweltErstellenZeit (WelcheZeitExtern, 1)),
                                   Fore => 1,
                                   Aft  => 6,
                                   Exp  => 0);
            New_Line;
      end case;
                  
   end LadezeitenSpielweltErstellen;
   
   
   
   procedure AnzeigeEinzelneZeit
     (WelcheZeitExtern : in Positive)
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                     TextDateiExtern        => GlobaleDatentypen.Ladezeiten,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => Aufschlag (WelcheZeitExtern),
                                     LetzteZeileExtern      => Aufschlag (WelcheZeitExtern),
                                     AbstandAnfangExtern    => GlobaleDatentypen.Keiner,
                                     AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                     AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);
      
      Ada.Float_Text_IO.Put (Item => Float (EinzelneZeiten (WelcheZeitExtern, 2) - EinzelneZeiten (WelcheZeitExtern, 1)),
                             Fore => 1,
                             Aft  => 6,
                             Exp  => 0);
      Eingabe.WartenEingabe;
      
   end AnzeigeEinzelneZeit;
   
   
   
   procedure AnzeigeKIZeit
     (WelcheZeitExtern : in Positive)
   is begin

      GesamtzeitKI := 0.00;
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                     TextDateiExtern        => GlobaleDatentypen.Ladezeiten,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => WelcheZeitExtern + KIAufschlag,
                                     LetzteZeileExtern      => WelcheZeitExtern + KIAufschlag,
                                     AbstandAnfangExtern    => GlobaleDatentypen.Keiner,
                                     AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                     AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);
      
      case
        WelcheZeitExtern
      is
         when 19 =>
            ZeitAuswahlSchleife:
            for VerschiedeneZeitenSchleifenwert in KIZeiten'First (1) .. KIZeiten'Last (1) - 1 loop                  
               
               GesamtzeitKI := GesamtzeitKI + Float (KIZeiten (VerschiedeneZeitenSchleifenwert, 2) - KIZeiten (VerschiedeneZeitenSchleifenwert, 1));
                  
            end loop ZeitAuswahlSchleife;
            Ada.Float_Text_IO.Put (Item => GesamtzeitKI,
                                   Fore => 1,
                                   Aft  => 6,
                                   Exp  => 0);
            New_Line;
            
         when others =>
            Ada.Float_Text_IO.Put (Item => Float (KIZeiten (WelcheZeitExtern, 2) - KIZeiten (WelcheZeitExtern, 1)),
                                   Fore => 1,
                                   Aft  => 6,
                                   Exp  => 0);
            New_Line;
      end case;
      
   end AnzeigeKIZeit;

end Ladezeiten;
