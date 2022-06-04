pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Characters.Wide_Wide_Latin_1; use Ada.Characters.Wide_Wide_Latin_1;

with ForschungenDatentypen; use ForschungenDatentypen;
with ForschungKonstanten;
with TastenbelegungDatentypen;

with LeseForschungenDatenbank;

with Eingabe;

package body ForschungAnzeigeTerminal is

   procedure ForschungAnzeige
   is begin
      
      null;
      
      -- Ermöglicht (RasseExtern           => RasseExtern,
      --             ForschungNummerExtern => EinheitenDatentypen.ForschungID (Anzeige.AllgemeineAnzeigeText (AktuelleAuswahl).Nummer));
      
   end ForschungAnzeige;
   
   
   
   procedure Ermöglicht
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      ForschungNummerExtern : in ForschungenDatentypen.ForschungID)
   is begin
      
      -- TextAnzeigeTerminal.AnzeigeLangerTextNeu (ÜberschriftDateiExtern => GlobaleTexte.Zeug,
      --                                         TextDateiExtern        => GlobaleTexte.Beschreibung_Forschung_Ermöglicht,
     --                                          ÜberschriftZeileExtern => 43,
     --                                          ErsteZeileExtern       => Positive (ForschungNummerExtern),
      --                                         AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
      --                                         AbstandEndeExtern      => GlobaleTexte.Leer);
      
      TechnologienSchleife:
      for TechnologieSchleifenwert in ForschungenDatentypen.ForschungID'Range loop
         ErmöglichtSchleife:
         for NeueForschungSchleifenwert in ForschungenDatentypen.AnforderungForschungArray'Range loop
         
            if
              LeseForschungenDatenbank.AnforderungForschung (RasseExtern             => RasseExtern,
                                                            IDExtern                => TechnologieSchleifenwert,
                                                            WelcheAnforderungExtern => NeueForschungSchleifenwert)
              = ForschungKonstanten.LeerForschungAnforderung
            then
               exit ErmöglichtSchleife;
            
            elsif
              LeseForschungenDatenbank.AnforderungForschung (RasseExtern             => RasseExtern,
                                                            IDExtern                => TechnologieSchleifenwert,
                                                            WelcheAnforderungExtern => NeueForschungSchleifenwert)
              = ForschungNummerExtern
            then
             --  TextAnzeigeTerminal.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
             --                                            TextDateiExtern        => GlobaleTexte.Beschreibungen_Forschung_Kurz,
             --                                            ÜberschriftZeileExtern => 0,
             --                                            ErsteZeileExtern       => Positive (TechnologieSchleifenwert),
             --                                            LetzteZeileExtern      => Positive (TechnologieSchleifenwert),
             --                                            AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
             --                                            AbstandMitteExtern     => GlobaleTexte.Großer_Abstand,
             --                                            AbstandEndeExtern      => GlobaleTexte.Leer);
               exit ErmöglichtSchleife;
               
            else
               null;
            end if;
         
         end loop ErmöglichtSchleife;
      end loop TechnologienSchleife;
      
      New_Line;
      
   end Ermöglicht;
   
   
   
   procedure Benötigt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      ForschungNummerExtern : in ForschungenDatentypen.ForschungID)
   is begin
      
      ErsterDurchlauf := True;
          
      BenötigtSchleife:
      for NeueForschungSchleifenwert in ForschungenDatentypen.AnforderungForschungArray'Range loop
         
         if
           LeseForschungenDatenbank.AnforderungForschung (RasseExtern             => RasseExtern,
                                                         IDExtern                => ForschungNummerExtern,
                                                         WelcheAnforderungExtern => NeueForschungSchleifenwert)
           = ForschungKonstanten.LeerForschungAnforderung
         then
            null;
               
         else
            case
              ErsterDurchlauf
            is
               when True =>
                --  TextAnzeigeTerminal.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Zeug,
                 --                                           TextDateiExtern        => GlobaleTexte.Beschreibungen_Forschung_Kurz,
                --                                            ÜberschriftZeileExtern => 44,
                --                                            ErsteZeileExtern       => Positive (LeseForschungenDatenbank.AnforderungForschung (RasseExtern             => RasseExtern,
                --                                                                                                                              IDExtern                => ForschungNummerExtern,
                --                                                                                                                              WelcheAnforderungExtern => NeueForschungSchleifenwert)),
                --                                            LetzteZeileExtern      => Positive (LeseForschungenDatenbank.AnforderungForschung (RasseExtern             => RasseExtern,
                --                                                                                                                              IDExtern                => ForschungNummerExtern,
                --                                                                                                                              WelcheAnforderungExtern => NeueForschungSchleifenwert)),
                --                                            AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                 --                                           AbstandMitteExtern     => GlobaleTexte.Großer_Abstand,
                 --                                           AbstandEndeExtern      => GlobaleTexte.Leer);
                  ErsterDurchlauf := False;
                  
               when False =>
                 -- TextAnzeigeTerminal.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                 --                                           TextDateiExtern        => GlobaleTexte.Beschreibungen_Forschung_Kurz,
                 --                                           ÜberschriftZeileExtern => 0,
                 --                                           ErsteZeileExtern       => Positive (LeseForschungenDatenbank.AnforderungForschung (RasseExtern             => RasseExtern,
                 --                                                                                                                             IDExtern                => ForschungNummerExtern,
                 --                                                                                                                             WelcheAnforderungExtern => NeueForschungSchleifenwert)),
                 --                                           LetzteZeileExtern      => Positive (LeseForschungenDatenbank.AnforderungForschung (RasseExtern             => RasseExtern,
                 --                                                                                                                             IDExtern                => ForschungNummerExtern,
                 --                                                                                                                             WelcheAnforderungExtern => NeueForschungSchleifenwert)),
                 --                                           AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                 --                                           AbstandMitteExtern     => GlobaleTexte.Großer_Abstand,
                 --                                           AbstandEndeExtern      => GlobaleTexte.Leer);
                 null;
            end case;
         end if;
         
      end loop BenötigtSchleife;
      
      New_Line;
      
   end Benötigt;
   
   
   
   procedure ForschungsBaum
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      AktuelleAuswahl := 1;
      
      ForschungsbaumSchleife:
      loop
         
         Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");
         
         -- TextAnzeigeTerminal.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Zeug,
         --                                          TextDateiExtern        => GlobaleTexte.Beschreibungen_Forschung_Kurz,
         --                                          ÜberschriftZeileExtern => 45,
         --                                          ErsteZeileExtern       => Positive (AktuelleAuswahl),
         --                                          LetzteZeileExtern      => Positive (AktuelleAuswahl),
         --                                          AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
         --                                          AbstandMitteExtern     => GlobaleTexte.Leer,
         --                                          AbstandEndeExtern      => GlobaleTexte.Neue_Zeile);         
         New_Line;
         
         -- TextAnzeigeTerminal.AnzeigeLangerTextNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
         --                                         TextDateiExtern        => GlobaleTexte.Beschreibungen_Forschung_Lang,
         --                                         ÜberschriftZeileExtern => 0,
         --                                         ErsteZeileExtern       => Positive (AktuelleAuswahl),
         --                                         AbstandAnfangExtern    => GlobaleTexte.Leer,
         --                                         AbstandEndeExtern      => GlobaleTexte.Neue_Zeile);         
         New_Line;
      
         Benötigt (RasseExtern           => RasseExtern,
                    ForschungNummerExtern => AktuelleAuswahl);
         New_Line;
         Ermöglicht (RasseExtern           => RasseExtern,
                      ForschungNummerExtern => AktuelleAuswahl);
         
         case
           Eingabe.Tastenwert
         is
            when TastenbelegungDatentypen.Rechts_Enum =>
               if
                 AktuelleAuswahl = ForschungenDatentypen.ForschungID'Last
               then
                  AktuelleAuswahl := ForschungenDatentypen.ForschungID'First;
                  
               else
                  AktuelleAuswahl := AktuelleAuswahl + 1;
               end if;

            when TastenbelegungDatentypen.Links_Enum =>
               if
                 AktuelleAuswahl = ForschungenDatentypen.ForschungID'First
               then
                  AktuelleAuswahl := ForschungenDatentypen.ForschungID'Last;
                  
               else
                  AktuelleAuswahl := AktuelleAuswahl - 1;
               end if;
                              
            when TastenbelegungDatentypen.Menü_Zurück_Enum =>
               Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");
               return;
                     
            when others =>
               null;
         end case;
         
      end loop ForschungsbaumSchleife;
      
   end ForschungsBaum;

end ForschungAnzeigeTerminal;
