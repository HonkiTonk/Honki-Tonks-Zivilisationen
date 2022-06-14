pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Calendar; use Ada.Calendar;

with EinheitenKonstanten;
with SystemDatentypen;

package body LadezeitenTerminal is

   procedure LadezeitenSpielweltErstellen
     -- (WelcheZeitExtern : in LadezeitenDatentypen.Spielwelt_Erstellen_Zeit_Verwendet_Enum)
   is begin

      GesamtzeitSpielweltErstellen := 0.00;
      
      -- TextAnzeigeTerminal.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
      --                                          TextDateiExtern        => GlobaleTexte.Ladezeiten,
      --                                          ÜberschriftZeileExtern => 0,
      --                                          ErsteZeileExtern       => LadezeitenDatentypen.Spielwelt_Erstellen_Zeit_Verwendet_Enum'Pos (WelcheZeitExtern),
      --                                          LetzteZeileExtern      => LadezeitenDatentypen.Spielwelt_Erstellen_Zeit_Verwendet_Enum'Pos (WelcheZeitExtern),
      --                                          AbstandAnfangExtern    => GlobaleTexte.Leer,
      --                                          AbstandMitteExtern     => GlobaleTexte.Leer,
      --                                          AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      
      case
        WelcheZeitExtern
      is
         when LadezeitenDatentypen.Gesamtzeit_Enum =>
            ZeitAuswahlSchleife:
            for VerschiedeneZeitenSchleifenwert in LadezeitenDatentypen.Gesamtzeit_Erstellen_Enum'Range loop
               
               GesamtzeitSpielweltErstellen
                 := GesamtzeitSpielweltErstellen
                   + Float (LadezeitenDatentypen.SpielweltErstellenZeit (VerschiedeneZeitenSchleifenwert, SystemDatentypen.Endwert_Enum)
                            - LadezeitenDatentypen.SpielweltErstellenZeit (VerschiedeneZeitenSchleifenwert, SystemDatentypen.Anfangswert_Enum));
               
            end loop ZeitAuswahlSchleife;
            AnzeigeFloat.Put (Item => GesamtzeitSpielweltErstellen,
                              Fore => 1,
                              Aft  => 6,
                              Exp  => 0);
            
         when others =>
            AnzeigeFloat.Put (Item => Float (LadezeitenDatentypen.SpielweltErstellenZeit (WelcheZeitExtern, SystemDatentypen.Endwert_Enum)
                              - LadezeitenDatentypen.SpielweltErstellenZeit (WelcheZeitExtern, SystemDatentypen.Anfangswert_Enum)),
                              Fore => 1,
                              Aft  => 6,
                              Exp  => 0);
            New_Line;
      end case;
                        
   end LadezeitenSpielweltErstellen;
   
   
   
   procedure AnzeigeEinzelneZeit
     (WelcheZeitExtern : in LadezeitenDatentypen.Einzelne_Zeiten_Enum)
   is begin
      
      AnzeigeEinzelneZeitOhneWarten (WelcheZeitExtern => WelcheZeitExtern);
      -- Eingabe.WartenEingabe;
      
   end AnzeigeEinzelneZeit;
   
   
   
   procedure AnzeigeEinzelneZeitOhneWarten
     (WelcheZeitExtern : in LadezeitenDatentypen.Einzelne_Zeiten_Enum)
   is begin
      
      -- TextAnzeigeTerminal.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
      --                                          TextDateiExtern        => GlobaleTexte.Ladezeiten,
      --                                          ÜberschriftZeileExtern => 0,
      --                                          ErsteZeileExtern       => LadezeitenDatentypen.Aufschlag (WelcheZeitExtern),
      --                                          LetzteZeileExtern      => LadezeitenDatentypen.Aufschlag (WelcheZeitExtern),
      --                                          AbstandAnfangExtern    => GlobaleTexte.Leer,
      --                                          AbstandMitteExtern     => GlobaleTexte.Leer,
      --                                          AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      
      AnzeigeFloat.Put (Item => Float (LadezeitenDatentypen.EinzelneZeiten (WelcheZeitExtern, SystemDatentypen.Endwert_Enum)
                        - LadezeitenDatentypen.EinzelneZeiten (WelcheZeitExtern, SystemDatentypen.Anfangswert_Enum)),
                        Fore => 1,
                        Aft  => 6,
                        Exp  => 0);
      New_Line;
      
   end AnzeigeEinzelneZeitOhneWarten;
   
   
   
   procedure AnzeigeKIZeit
     (WelcheZeitExtern : in RassenDatentypen.Rassen_Enum)
   is begin
      
      -- TextAnzeigeTerminal.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
      --                                          TextDateiExtern        => GlobaleTexte.Ladezeiten,
      --                                          ÜberschriftZeileExtern => 0,
      --                                          ErsteZeileExtern       => LadezeitenDatentypen.KIText (WelcheZeitExtern),
      --                                          LetzteZeileExtern      => LadezeitenDatentypen.KIText (WelcheZeitExtern),
      --                                          AbstandAnfangExtern    => GlobaleTexte.Leer,
      --                                          AbstandMitteExtern     => GlobaleTexte.Leer,
      --                                          AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      
      case
        WelcheZeitExtern
      is
         when EinheitenKonstanten.LeerRasse =>
            GesamtzeitKI := 0.00;
            
            ZeitAuswahlSchleife:
            for VerschiedeneZeitenSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
               
               GesamtzeitKI := GesamtzeitKI + Float (LadezeitenDatentypen.KIZeiten (VerschiedeneZeitenSchleifenwert, SystemDatentypen.Endwert_Enum)
                                                     - LadezeitenDatentypen.KIZeiten (VerschiedeneZeitenSchleifenwert, SystemDatentypen.Anfangswert_Enum));
                  
            end loop ZeitAuswahlSchleife;
            
            AnzeigeFloat.Put (Item => GesamtzeitKI,
                              Fore => 1,
                              Aft  => 6,
                              Exp  => 0);
            New_Line;
            
         when others =>
            AnzeigeFloat.Put (Item => Float (LadezeitenDatentypen.KIZeiten (WelcheZeitExtern, SystemDatentypen.Endwert_Enum) - LadezeitenDatentypen.KIZeiten (WelcheZeitExtern, SystemDatentypen.Anfangswert_Enum)),
                              Fore => 1,
                              Aft  => 6,
                              Exp  => 0);
            New_Line;
      end case;
      
   end AnzeigeKIZeit;

end LadezeitenTerminal;
