pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Float_Text_IO;
use Ada.Wide_Wide_Text_IO;

with GlobaleDatentypen;

with Anzeige;

package body Ladezeiten is

   procedure LadezeitenSpielweltErstellen (WelcheZeitExtern : in Natural) is
   begin

      Gesamtzeit := 0.00;
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                     TextDateiExtern        => GlobaleDatentypen.Ladezeiten,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => WelcheZeitExtern + 1,
                                     LetzteZeileExtern      => WelcheZeitExtern + 1,
                                     AbstandAnfangExtern    => GlobaleDatentypen.Keiner,
                                     AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                     AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);
      
      case
        WelcheZeitExtern
      is
         when 0 =>
            ZeitAuswahlSchleife:
            for VerschiedeneZeitenSchleifenwert in LadezeitenSpielweltErstellenZeit'Range (2) loop
               ZeitUnterschiedSchleife:
               for ZeitAnfangEndeSchleifenwert in LadezeitenSpielweltErstellenZeit'Range (1) loop
                  
                  case
                    ZeitAnfangEndeSchleifenwert
                  is
                     when 2 =>
                        Gesamtzeit:= Gesamtzeit + Float (LadezeitenSpielweltErstellenZeit (ZeitAnfangEndeSchleifenwert, VerschiedeneZeitenSchleifenwert)
                                                         - LadezeitenSpielweltErstellenZeit (ZeitAnfangEndeSchleifenwert - 1, VerschiedeneZeitenSchleifenwert));

                     when 1 =>
                        null;
                  end case;
                  
               end loop ZeitUnterschiedSchleife;
            end loop ZeitAuswahlSchleife;
            Ada.Float_Text_IO.Put (Item => Gesamtzeit,
                                   Fore => 1,
                                   Aft  => 6,
                                   Exp  => 0);
            Get_Immediate (Item => Warten);
            
         when others =>
            Ada.Float_Text_IO.Put (Item => Float (LadezeitenSpielweltErstellenZeit (2, WelcheZeitExtern) - LadezeitenSpielweltErstellenZeit (1, WelcheZeitExtern)),
                                   Fore => 1,
                                   Aft  => 6,
                                   Exp  => 0);
            New_Line;
      end case;
                  
   end LadezeitenSpielweltErstellen;




   procedure Speichern (WelcheZeitExtern : in Positive) is
   begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                     TextDateiExtern        => GlobaleDatentypen.Ladezeiten,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => WelcheZeitExtern + AufschlagSpeichern,
                                     LetzteZeileExtern      => WelcheZeitExtern + AufschlagSpeichern,
                                     AbstandAnfangExtern    => GlobaleDatentypen.Keiner,
                                     AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                     AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);

      case
        WelcheZeitExtern
      is
         when others =>
            Ada.Float_Text_IO.Put (Item => Float (Speicherzeiten (2, WelcheZeitExtern) - Speicherzeiten (1, WelcheZeitExtern)),
                                   Fore => 1,
                                   Aft  => 6,
                                   Exp  => 0);
            Get_Immediate (Item => Warten);
      end case;
      
   end Speichern;
   
   
   
   procedure Laden (WelcheZeitExtern : in Positive) is
   begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                     TextDateiExtern        => GlobaleDatentypen.Ladezeiten,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => WelcheZeitExtern + AufschlagLaden,
                                     LetzteZeileExtern      => WelcheZeitExtern + AufschlagLaden,
                                     AbstandAnfangExtern    => GlobaleDatentypen.Keiner,
                                     AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                     AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);

      case
        WelcheZeitExtern
      is
         when others =>
            Ada.Float_Text_IO.Put (Item => Float (LadenLadezeiten (2, WelcheZeitExtern) - LadenLadezeiten (1, WelcheZeitExtern)),
                                   Fore => 1,
                                   Aft  => 6,
                                   Exp  => 0);
            Get_Immediate (Item => Warten);
      end case;
      
   end Laden;
   
   
   
   procedure SpielStart (WelcheZeitExtern : in Positive) is
   begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                     TextDateiExtern        => GlobaleDatentypen.Ladezeiten,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => WelcheZeitExtern + AufschlagSpielstart,
                                     LetzteZeileExtern      => WelcheZeitExtern + AufschlagSpielstart,
                                     AbstandAnfangExtern    => GlobaleDatentypen.Keiner,
                                     AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                     AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);

      case
        WelcheZeitExtern
      is
         when others =>
            Ada.Float_Text_IO.Put (Item => Float (SpielStartzeiten (2, WelcheZeitExtern) - SpielStartzeiten (1, WelcheZeitExtern))
                                   + Float (SpielStartzeiten (2, WelcheZeitExtern + 1) - SpielStartzeiten (1, WelcheZeitExtern + 1)),
                                   Fore => 1,
                                   Aft  => 6,
                                   Exp  => 0);
            Get_Immediate (Item => Warten);
      end case;
            
   end SpielStart;



   procedure BerechnungenNachZugendeAllerSpieler (WelcheZeitExtern : in Positive) is
   begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                     TextDateiExtern        => GlobaleDatentypen.Ladezeiten,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => WelcheZeitExtern + AufschlagZwischenDenRunden,
                                     LetzteZeileExtern      => WelcheZeitExtern + AufschlagZwischenDenRunden,
                                     AbstandAnfangExtern    => GlobaleDatentypen.Keiner,
                                     AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                     AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);

      case
        WelcheZeitExtern
      is
         when others =>
            Ada.Float_Text_IO.Put (Item => Float (BerechnungenNachZugendeAllerSpielerZeiten (2, WelcheZeitExtern) - BerechnungenNachZugendeAllerSpielerZeiten (1, WelcheZeitExtern)),
                                   Fore => 1,
                                   Aft  => 6,
                                   Exp  => 0);
            Get_Immediate (Item => Warten);
      end case;
            
      
   end BerechnungenNachZugendeAllerSpieler;



   procedure KIZeit (WelcheZeitExtern : in Positive) is
   begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                     TextDateiExtern        => GlobaleDatentypen.Ladezeiten,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => WelcheZeitExtern + AufschlagKIRechenzeit,
                                     LetzteZeileExtern      => WelcheZeitExtern + AufschlagKIRechenzeit,
                                     AbstandAnfangExtern    => GlobaleDatentypen.Keiner,
                                     AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                     AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);

      case
        WelcheZeitExtern
      is
         when others =>
            Ada.Float_Text_IO.Put (Item => Float (KIZeiten (2, WelcheZeitExtern) - KIZeiten (1, WelcheZeitExtern)),
                                   Fore => 1,
                                   Aft  => 6,
                                   Exp  => 0);
            Get_Immediate (Item => Warten);
      end case;
      
   end KIZeit;

end Ladezeiten;
