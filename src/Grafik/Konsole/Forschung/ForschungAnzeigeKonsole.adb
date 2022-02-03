pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Characters.Wide_Wide_Latin_1; use Ada.Characters.Wide_Wide_Latin_1;

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with ForschungKonstanten;
with GlobaleTexte;

with LeseForschungsDatenbank;

with TextAnzeigeKonsole;
with Eingabe;

package body ForschungAnzeigeKonsole is

   procedure ForschungAnzeige
   is begin
      
      null;
      
      -- Ermöglicht (RasseExtern           => RasseExtern,
      --             ForschungNummerExtern => EinheitStadtDatentypen.ForschungID (Anzeige.AllgemeineAnzeigeText (AktuelleAuswahl).Nummer));
      
   end ForschungAnzeige;
   
   
   
   procedure Ermöglicht
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      ForschungNummerExtern : in EinheitStadtDatentypen.ForschungID)
   is begin
      
      TextAnzeigeKonsole.AnzeigeLangerTextNeu (ÜberschriftDateiExtern => GlobaleTexte.Zeug,
                                               TextDateiExtern        => GlobaleTexte.Beschreibung_Forschung_Ermöglicht,
                                               ÜberschriftZeileExtern => 43,
                                               ErsteZeileExtern       => Positive (ForschungNummerExtern),
                                               AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                               AbstandEndeExtern      => GlobaleTexte.Leer);
      
      TechnologienSchleife:
      for TechnologieSchleifenwert in EinheitStadtDatentypen.ForschungID'Range loop
         ErmöglichtSchleife:
         for NeueForschungSchleifenwert in EinheitStadtDatentypen.AnforderungForschungArray'Range loop
         
            if
              LeseForschungsDatenbank.AnforderungForschung (RasseExtern             => RasseExtern,
                                                            IDExtern                => TechnologieSchleifenwert,
                                                            WelcheAnforderungExtern => NeueForschungSchleifenwert)
              = ForschungKonstanten.LeerForschungAnforderung
            then
               exit ErmöglichtSchleife;
            
            elsif
              LeseForschungsDatenbank.AnforderungForschung (RasseExtern             => RasseExtern,
                                                            IDExtern                => TechnologieSchleifenwert,
                                                            WelcheAnforderungExtern => NeueForschungSchleifenwert)
              = ForschungNummerExtern
            then
               TextAnzeigeKonsole.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                                         TextDateiExtern        => GlobaleTexte.Beschreibungen_Forschung_Kurz,
                                                         ÜberschriftZeileExtern => 0,
                                                         ErsteZeileExtern       => Positive (TechnologieSchleifenwert),
                                                         LetzteZeileExtern      => Positive (TechnologieSchleifenwert),
                                                         AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                                         AbstandMitteExtern     => GlobaleTexte.Großer_Abstand,
                                                         AbstandEndeExtern      => GlobaleTexte.Leer);
               exit ErmöglichtSchleife;
               
            else
               null;
            end if;
         
         end loop ErmöglichtSchleife;
      end loop TechnologienSchleife;
      
      New_Line;
      
   end Ermöglicht;
   
   
   
   procedure Benötigt
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      ForschungNummerExtern : in EinheitStadtDatentypen.ForschungID)
   is begin
      
      ErsterDurchlauf := True;
          
      BenötigtSchleife:
      for NeueForschungSchleifenwert in EinheitStadtDatentypen.AnforderungForschungArray'Range loop
         
         if
           LeseForschungsDatenbank.AnforderungForschung (RasseExtern             => RasseExtern,
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
                  TextAnzeigeKonsole.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Zeug,
                                                            TextDateiExtern        => GlobaleTexte.Beschreibungen_Forschung_Kurz,
                                                            ÜberschriftZeileExtern => 44,
                                                            ErsteZeileExtern       => Positive (LeseForschungsDatenbank.AnforderungForschung (RasseExtern             => RasseExtern,
                                                                                                                                              IDExtern                => ForschungNummerExtern,
                                                                                                                                              WelcheAnforderungExtern => NeueForschungSchleifenwert)),
                                                            LetzteZeileExtern      => Positive (LeseForschungsDatenbank.AnforderungForschung (RasseExtern             => RasseExtern,
                                                                                                                                              IDExtern                => ForschungNummerExtern,
                                                                                                                                              WelcheAnforderungExtern => NeueForschungSchleifenwert)),
                                                            AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                                            AbstandMitteExtern     => GlobaleTexte.Großer_Abstand,
                                                            AbstandEndeExtern      => GlobaleTexte.Leer);
                  ErsterDurchlauf := False;
                  
               when False =>
                  TextAnzeigeKonsole.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                                            TextDateiExtern        => GlobaleTexte.Beschreibungen_Forschung_Kurz,
                                                            ÜberschriftZeileExtern => 0,
                                                            ErsteZeileExtern       => Positive (LeseForschungsDatenbank.AnforderungForschung (RasseExtern             => RasseExtern,
                                                                                                                                              IDExtern                => ForschungNummerExtern,
                                                                                                                                              WelcheAnforderungExtern => NeueForschungSchleifenwert)),
                                                            LetzteZeileExtern      => Positive (LeseForschungsDatenbank.AnforderungForschung (RasseExtern             => RasseExtern,
                                                                                                                                              IDExtern                => ForschungNummerExtern,
                                                                                                                                              WelcheAnforderungExtern => NeueForschungSchleifenwert)),
                                                            AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                                            AbstandMitteExtern     => GlobaleTexte.Großer_Abstand,
                                                            AbstandEndeExtern      => GlobaleTexte.Leer);
            end case;
         end if;
         
      end loop BenötigtSchleife;
      
      New_Line;
      
   end Benötigt;
   
   
   
   procedure ForschungsBaum
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      AktuelleAuswahl := 1;
      
      ForschungsbaumSchleife:
      loop
         
         Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");
         
         TextAnzeigeKonsole.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Zeug,
                                                   TextDateiExtern        => GlobaleTexte.Beschreibungen_Forschung_Kurz,
                                                   ÜberschriftZeileExtern => 45,
                                                   ErsteZeileExtern       => Positive (AktuelleAuswahl),
                                                   LetzteZeileExtern      => Positive (AktuelleAuswahl),
                                                   AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                                   AbstandMitteExtern     => GlobaleTexte.Leer,
                                                   AbstandEndeExtern      => GlobaleTexte.Neue_Zeile);         
         New_Line;
         
         TextAnzeigeKonsole.AnzeigeLangerTextNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                                  TextDateiExtern        => GlobaleTexte.Beschreibungen_Forschung_Lang,
                                                  ÜberschriftZeileExtern => 0,
                                                  ErsteZeileExtern       => Positive (AktuelleAuswahl),
                                                  AbstandAnfangExtern    => GlobaleTexte.Leer,
                                                  AbstandEndeExtern      => GlobaleTexte.Neue_Zeile);         
         New_Line;
      
         Benötigt (RasseExtern           => RasseExtern,
                    ForschungNummerExtern => AktuelleAuswahl);
         New_Line;
         Ermöglicht (RasseExtern           => RasseExtern,
                      ForschungNummerExtern => AktuelleAuswahl);
         
         case
           Eingabe.Tastenwert
         is
            when SystemKonstanten.RechtsKonstante =>
               if
                 AktuelleAuswahl = EinheitStadtDatentypen.ForschungID'Last
               then
                  AktuelleAuswahl := EinheitStadtDatentypen.ForschungID'First;
                  
               else
                  AktuelleAuswahl := AktuelleAuswahl + 1;
               end if;

            when SystemKonstanten.LinksKonstante =>
               if
                 AktuelleAuswahl = EinheitStadtDatentypen.ForschungID'First
               then
                  AktuelleAuswahl := EinheitStadtDatentypen.ForschungID'Last;
                  
               else
                  AktuelleAuswahl := AktuelleAuswahl - 1;
               end if;
                              
            when SystemKonstanten.MenüZurückKonstante =>
               Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");
               return;
                     
            when others =>
               null;
         end case;
         
      end loop ForschungsbaumSchleife;
      
   end ForschungsBaum;

end ForschungAnzeigeKonsole;
