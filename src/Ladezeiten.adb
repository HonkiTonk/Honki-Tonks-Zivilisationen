pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Float_Text_IO;
use Ada.Wide_Wide_Text_IO;

with Anzeige;

package body Ladezeiten is

   procedure LadezeitenSpielweltErstellen (WelcheZeit : in Positive) is
   begin

      Gesamtzeit := 0.00;

      Anzeige.AnzeigeNeu (AuswahlOderAnzeige => False,
                          AktuelleAuswahl    => 0,
                          FrageDatei         => 0,
                          FrageZeile         => 0,
                          TextDatei          => 11,
                          ErsteZeile         => WelcheZeit,
                          LetzteZeile        => WelcheZeit);
      
      case WelcheZeit is
         when 1 =>
            ZeitAuswahlSchleife:
            for VerschiedeneZeiten in LadezeitenSpielweltErstellenZeit'Range (2) loop
               ZeitUnterschiedSchleife:
               for ZeitAnfangEnde in LadezeitenSpielweltErstellenZeit'Range (1) loop
                  
                  case ZeitAnfangEnde is
                     when 2 =>
                        Gesamtzeit := Gesamtzeit + Float (LadezeitenSpielweltErstellenZeit (ZeitAnfangEnde, VerschiedeneZeiten) - LadezeitenSpielweltErstellenZeit (ZeitAnfangEnde - 1, VerschiedeneZeiten));

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
            Ada.Float_Text_IO.Put (Item => Float (LadezeitenSpielweltErstellenZeit (2, WelcheZeit) - LadezeitenSpielweltErstellenZeit (1, WelcheZeit)),
                                   Fore => 1,
                                   Aft  => 6,
                                   Exp  => 0);
            New_Line;
      end case;
                  
   end LadezeitenSpielweltErstellen;




   procedure Speichern (WelcheZeit : in Positive) is
   begin
      
      Anzeige.AnzeigeNeu (AuswahlOderAnzeige => False,
                          AktuelleAuswahl    => 0,
                          FrageDatei         => 0,
                          FrageZeile         => 0,
                          TextDatei          => 11,
                          ErsteZeile         => WelcheZeit + AufschlagSpeichern,
                          LetzteZeile        => WelcheZeit + AufschlagSpeichern);

      case WelcheZeit is
         when others =>
            Ada.Float_Text_IO.Put (Item => Float (Speicherzeiten (2, WelcheZeit) - Speicherzeiten (1, WelcheZeit)),
                                   Fore => 1,
                                   Aft  => 6,
                                   Exp  => 0);
            Get_Immediate (Item => Warten);
      end case;
      
   end Speichern;
   
   
   
   procedure Laden (WelcheZeit : in Positive) is
   begin
      
      Anzeige.AnzeigeNeu (AuswahlOderAnzeige => False,
                          AktuelleAuswahl    => 0,
                          FrageDatei         => 0,
                          FrageZeile         => 0,
                          TextDatei          => 11,
                          ErsteZeile         => WelcheZeit + AufschlagLaden,
                          LetzteZeile        => WelcheZeit + AufschlagLaden);

      case WelcheZeit is
         when others =>
            Ada.Float_Text_IO.Put (Item => Float (LadenLadezeiten (2, WelcheZeit) - LadenLadezeiten (1, WelcheZeit)),
                                   Fore => 1,
                                   Aft  => 6,
                                   Exp  => 0);
            Get_Immediate (Item => Warten);
      end case;
      
   end Laden;
   
   
   
   procedure SpielStart (WelcheZeit : in Positive) is
   begin
      
      Anzeige.AnzeigeNeu (AuswahlOderAnzeige => False,
                          AktuelleAuswahl    => 0,
                          FrageDatei         => 0,
                          FrageZeile         => 0,
                          TextDatei          => 11,
                          ErsteZeile         => WelcheZeit + AufschlagSpielstart,
                          LetzteZeile        => WelcheZeit + AufschlagSpielstart);

      case WelcheZeit is
         when others =>
            Ada.Float_Text_IO.Put (Item => Float (SpielStartzeiten (2, WelcheZeit) - SpielStartzeiten (1, WelcheZeit)),
                                   Fore => 1,
                                   Aft  => 6,
                                   Exp  => 0);
            Get_Immediate (Item => Warten);
      end case;
            
   end SpielStart;



   procedure BerechnungenNachZugendeAllerSpieler (WelcheZeit : in Positive) is
   begin
      
      Put (Item => "Berechnungszeit am Zugende aller Spieler: ");

      case WelcheZeit is
         when others =>
            Ada.Float_Text_IO.Put (Item => Float (SpielStartzeiten (2, WelcheZeit) - SpielStartzeiten (1, WelcheZeit)),
                                   Fore => 1,
                                   Aft  => 6,
                                   Exp  => 0);
            Get_Immediate (Item => Warten);
      end case;
            
      
   end BerechnungenNachZugendeAllerSpieler;



   procedure KIZeit (WelcheZeit : in Positive) is
   begin
      
      null;
      
   end KIZeit;

end Ladezeiten;
