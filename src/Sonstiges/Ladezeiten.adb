pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Float_Text_IO;

-- with Sf.Graphics.Text;

with GlobaleTexte;
with EinheitenKonstanten;

with Anzeige;
-- with GrafikAllgemein;
-- with GrafikEinstellungen;

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
               
               GesamtzeitSpielweltErstellen
                 := GesamtzeitSpielweltErstellen
                   + Float (SpielweltErstellenZeit (VerschiedeneZeitenSchleifenwert, SystemDatentypen.Endwert) - SpielweltErstellenZeit (VerschiedeneZeitenSchleifenwert, SystemDatentypen.Anfangswert));
               
            end loop ZeitAuswahlSchleife;
            Ada.Float_Text_IO.Put (Item => GesamtzeitSpielweltErstellen,
                                   Fore => 1,
                                   Aft  => 6,
                                   Exp  => 0);
            
         when others =>
            Ada.Float_Text_IO.Put (Item => Float (SpielweltErstellenZeit (WelcheZeitExtern, SystemDatentypen.Endwert) - SpielweltErstellenZeit (WelcheZeitExtern, SystemDatentypen.Anfangswert)),
                                   Fore => 1,
                                   Aft  => 6,
                                   Exp  => 0);
            New_Line;
      end case;
                        
   end LadezeitenSpielweltErstellen;
   
   
   
   procedure AnzeigeEinzelneZeit
     (WelcheZeitExtern : in Einzelne_Zeiten_Enum)
   is begin
      
      AnzeigeEinzelneZeitOhneWarten (WelcheZeitExtern => WelcheZeitExtern);
      -- Eingabe.WartenEingabe;
      
   end AnzeigeEinzelneZeit;
   
   
   
   procedure AnzeigeEinzelneZeitOhneWarten
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
      
      Ada.Float_Text_IO.Put (Item => Float (EinzelneZeiten (WelcheZeitExtern, SystemDatentypen.Endwert) - EinzelneZeiten (WelcheZeitExtern, SystemDatentypen.Anfangswert)),
                             Fore => 1,
                             Aft  => 6,
                             Exp  => 0);
      New_Line;
      
   end AnzeigeEinzelneZeitOhneWarten;
   
   
   
   procedure AnzeigeKIZeit
     (WelcheZeitExtern : in SystemDatentypen.Rassen_Enum)
   is begin
      
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
         when EinheitenKonstanten.LeerRasse =>
            GesamtzeitKI := 0.00;
            
            ZeitAuswahlSchleife:
            for VerschiedeneZeitenSchleifenwert in SystemDatentypen.Rassen_Verwendet_Enum'Range loop
               
               GesamtzeitKI := GesamtzeitKI + Float (KIZeiten (VerschiedeneZeitenSchleifenwert, SystemDatentypen.Endwert) - KIZeiten (VerschiedeneZeitenSchleifenwert, SystemDatentypen.Anfangswert));
                  
            end loop ZeitAuswahlSchleife;
            
            Ada.Float_Text_IO.Put (Item => GesamtzeitKI,
                                   Fore => 1,
                                   Aft  => 6,
                                   Exp  => 0);
            New_Line;
            
         when others =>
            Ada.Float_Text_IO.Put (Item => Float (KIZeiten (WelcheZeitExtern, SystemDatentypen.Endwert) - KIZeiten (WelcheZeitExtern, SystemDatentypen.Anfangswert)),
                                   Fore => 1,
                                   Aft  => 6,
                                   Exp  => 0);
            New_Line;
      end case;
      
   end AnzeigeKIZeit;

end Ladezeiten;
