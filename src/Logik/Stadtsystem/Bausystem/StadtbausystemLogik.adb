with GrafikDatentypen;
with TastenbelegungDatentypen;
with TextnummernKonstanten;
with Grafiktask;
with AuswahlKonstanten;

with SchreibeStadtGebaut;
with LeseStadtGebaut;
with SchreibeGrafiktask;

with TasteneingabeLogik;
with GebaeudeanforderungenLogik;
with EinheitenanforderungenLogik;
with MausauswahlLogik;
with OftVerwendetSound;
with UmwandlungenDatentypen;
with JaNeinLogik;

package body StadtbausystemLogik is

   procedure Bauen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is
      use type StadtRecords.BauprojektRecord;
   begin
      
      NeuesBauprojekt := AuswahlBauprojekt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                            AktuelleBauprojektExtern => LeseStadtGebaut.Bauprojekt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern));
      
      if
        (NeuesBauprojekt.Gebäude = AuswahlKonstanten.LeerGebäudeauswahl
         and
           NeuesBauprojekt.Einheit = AuswahlKonstanten.LeerEinheitenauswahl)
        or
          NeuesBauprojekt = LeseStadtGebaut.Bauprojekt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern)
      then
         null;
            
      else
         SchreibeStadtGebaut.Bauprojekt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                         BauprojektExtern         => NeuesBauprojekt);
         SchreibeStadtGebaut.Material (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                       MaterialExtern           => StadtKonstanten.LeerMaterial,
                                       ÄndernSetzenExtern       => False);
      end if;
      
      SchreibeGrafiktask.Darstellung (DarstellungExtern => GrafikDatentypen.Stadtumgebung_Enum);
      
   end Bauen;
   
   
   
   function AuswahlBauprojekt
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      AktuelleBauprojektExtern : in StadtRecords.BauprojektRecord)
      return StadtRecords.BauprojektRecord
   is
      use type StadtDatentypen.Bauprojektart_Enum;
   begin
      
      InteraktionAuswahl.MöglicheBauoptionen := (others => AuswahlKonstanten.LeerAuswahl);
            
      case
        Grafiktask.WelchesBaumenü
      is
         when StadtDatentypen.Gebäudeart_Enum =>
            MöglicheGebäudeErmitteln (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                        ListenrichtungExtern     => SystemDatentypen.Neutral_Enum);
            
         when StadtDatentypen.Einheitenart_Enum =>
            MöglicheEinheitenErmitteln (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                         ListenrichtungExtern     => SystemDatentypen.Neutral_Enum);
      end case;
      
      SchreibeGrafiktask.Darstellung (DarstellungExtern => GrafikDatentypen.Bauen_Enum);
      
      AuswahlSchleife:
      loop
         
         AktuelleAuswahl := MausauswahlLogik.Baumenü;
         
         SchreibeGrafiktask.Bauauswahl (AuswahlExtern => UmwandlungenDatentypen.AuswahlBauprojekt (AuswahlExtern => AktuelleAuswahl.Bauauswahl));
         
         -- Das auch mal in die Lese/Schreibebereiche packen. äöü
         Grafiktask.Auswahl.Bauauswahl.Bauprojektart := AktuelleAuswahl.Bauprojektart;
         
         case
           TasteneingabeLogik.VereinfachteEingabe
         is               
            when TastenbelegungDatentypen.Auswählen_Enum =>
               if
                 AktuelleAuswahl.Bauprojektart /= StadtDatentypen.Leer_Bauprojektart
               then
                  Grafiktask.WelchesBaumenü := AktuelleAuswahl.Bauprojektart;
                  InteraktionAuswahl.MöglicheBauoptionen := (others => AuswahlKonstanten.LeerAuswahl);
                  
                  case
                    Grafiktask.WelchesBaumenü
                  is
                     when StadtDatentypen.Gebäudeart_Enum =>
                        MöglicheGebäudeErmitteln (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                    ListenrichtungExtern     => SystemDatentypen.Neutral_Enum);
            
                     when StadtDatentypen.Einheitenart_Enum =>
                        MöglicheEinheitenErmitteln (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                     ListenrichtungExtern     => SystemDatentypen.Neutral_Enum);
                  end case;
                  
               elsif
                 AktuelleAuswahl.Bauauswahl = AuswahlKonstanten.LeerAuswahl
               then
                  null;
                  
               elsif
                 AktuelleAuswahl.Bauauswahl = InteraktionAuswahl.BaulisteZurück
                 or
                   AktuelleAuswahl.Bauauswahl = InteraktionAuswahl.BaulisteWeiter
               then
                  case
                    Grafiktask.WelchesBaumenü
                  is
                     when StadtDatentypen.Gebäudeart_Enum =>
                        MöglicheGebäudeErmitteln (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                    ListenrichtungExtern     => Auswahlaufteilung (AktuelleAuswahl.Bauauswahl));
            
                     when StadtDatentypen.Einheitenart_Enum =>
                        MöglicheEinheitenErmitteln (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                     ListenrichtungExtern     => Auswahlaufteilung (AktuelleAuswahl.Bauauswahl));
                  end case;
                  
               elsif
                 AktuelleBauprojektExtern.Gebäude = AuswahlKonstanten.LeerGebäudeauswahl
                 and
                   AktuelleBauprojektExtern.Einheit = AuswahlKonstanten.LeerEinheitenauswahl
               then
                  OftVerwendetSound.Klick;
                  return UmwandlungenDatentypen.AuswahlBauprojekt (AuswahlExtern => InteraktionAuswahl.MöglicheBauoptionen (AktuelleAuswahl.Bauauswahl));
                  
               elsif
                 AktuelleAuswahl.Bauauswahl /= AuswahlKonstanten.LeerAuswahl
               then
                  GewähltesBauprojekt := UmwandlungenDatentypen.AuswahlBauprojekt (AuswahlExtern => AktuelleAuswahl.Bauauswahl);
                    
                  if
                    ((GewähltesBauprojekt.Gebäude /= AktuelleBauprojektExtern.Gebäude
                      and
                        GewähltesBauprojekt.Gebäude /= AuswahlKonstanten.LeerGebäudeauswahl)
                     or
                       (GewähltesBauprojekt.Einheit /= AktuelleBauprojektExtern.Einheit
                        and
                          GewähltesBauprojekt.Einheit /= AuswahlKonstanten.LeerEinheitenauswahl))
                    and then
                      JaNeinLogik.JaNein (FrageZeileExtern => TextnummernKonstanten.FrageBauprojektWechseln) = False
                  then
                     null;
                     
                  else
                     OftVerwendetSound.Klick;
                     return UmwandlungenDatentypen.AuswahlBauprojekt (AuswahlExtern => InteraktionAuswahl.MöglicheBauoptionen (AktuelleAuswahl.Bauauswahl));
                  end if;
                  
               else
                  null;
               end if;
               
            when TastenbelegungDatentypen.Abwählen_Enum =>
               return StadtKonstanten.LeerBauprojekt;
               
            when others =>
               null;
         end case;
         
      end loop AuswahlSchleife;
      
   end AuswahlBauprojekt;
   
   
   
   procedure MöglicheGebäudeErmitteln
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      ListenrichtungExtern : in SystemDatentypen.Erweiterter_Boolean_Enum)
   is begin
      
      case
        ListenrichtungExtern
      is
         when SystemDatentypen.Neutral_Enum | SystemDatentypen.False_Enum =>
            GebäudeermittlungVorwärts (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
            
         when SystemDatentypen.True_Enum =>
            GebäudeermittlungRückwärts (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      end case;
      
   end MöglicheGebäudeErmitteln;
   
   
   
   procedure GebäudeermittlungVorwärts
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is begin
      
      case
        InteraktionAuswahl.MöglicheBauoptionen (InteraktionAuswahl.BaulisteWeiter)
      is
         when AuswahlKonstanten.ErstAuswahl =>
            AnfangSchleife:
            for AnfangSchleifenwert in InteraktionAuswahl.BaulisteAnfang .. InteraktionAuswahl.BaulisteEnde loop

               if
                 InteraktionAuswahl.MöglicheBauoptionen (AnfangSchleifenwert) = AuswahlKonstanten.LeerAuswahl
               then
                  GebäudeAnfang := StadtDatentypen.GebäudeIDVorhanden'First;
                  exit AnfangSchleife;

               elsif
                 StadtDatentypen.GebäudeIDVorhanden'Last = StadtDatentypen.GebäudeID (InteraktionAuswahl.MöglicheBauoptionen (AnfangSchleifenwert))
               then
                  GebäudeAnfang := StadtDatentypen.GebäudeIDVorhanden'First;
                  exit AnfangSchleife;

               elsif
                 AnfangSchleifenwert = InteraktionAuswahl.BaulisteEnde
               then
                  GebäudeAnfang := StadtDatentypen.GebäudeIDVorhanden (InteraktionAuswahl.MöglicheBauoptionen (InteraktionAuswahl.BaulisteEnde) + 1);
                  exit AnfangSchleife;

               else
                  null;
               end if;

            end loop AnfangSchleife;

         when others =>
            GebäudeAnfang := StadtDatentypen.GebäudeIDVorhanden'First;
      end case;
      
      Baumöglichkeiten := InteraktionAuswahl.BaulisteAnfang;
      InteraktionAuswahl.MöglicheBauoptionen (InteraktionAuswahl.BaulisteAnfang .. InteraktionAuswahl.BaulisteEnde) := (others => AuswahlKonstanten.LeerAuswahl);
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in GebäudeAnfang .. StadtDatentypen.GebäudeIDVorhanden'Last loop
         
         if
           False = GebaeudeanforderungenLogik.AnforderungenErfüllt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                                     IDExtern                 => GebäudeSchleifenwert)
         then
            null;
            
         elsif
           Baumöglichkeiten <= InteraktionAuswahl.BaulisteEnde
         then
            InteraktionAuswahl.MöglicheBauoptionen (Baumöglichkeiten) := Positive (GebäudeSchleifenwert);
            Baumöglichkeiten := Baumöglichkeiten + 1;
                  
         else
            InteraktionAuswahl.MöglicheBauoptionen (InteraktionAuswahl.BaulisteZurück) := AuswahlKonstanten.ErstAuswahl;
            InteraktionAuswahl.MöglicheBauoptionen (InteraktionAuswahl.BaulisteWeiter) := AuswahlKonstanten.ErstAuswahl;
            exit GebäudeSchleife;
         end if;
         
      end loop GebäudeSchleife;
      
   end GebäudeermittlungVorwärts;
   
   
   
   procedure GebäudeermittlungRückwärts
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is begin
                  
      case
        InteraktionAuswahl.MöglicheBauoptionen (InteraktionAuswahl.BaulisteZurück)
      is
         when AuswahlKonstanten.ErstAuswahl =>
            EndeSchleife:
            for AnfangSchleifenwert in reverse InteraktionAuswahl.BaulisteAnfang .. InteraktionAuswahl.BaulisteEnde loop

               if
                 InteraktionAuswahl.MöglicheBauoptionen (AnfangSchleifenwert) = AuswahlKonstanten.LeerAuswahl
               then
                  GebäudeEnde := StadtDatentypen.GebäudeIDVorhanden'Last;
                  exit EndeSchleife;

               elsif
                 StadtDatentypen.GebäudeIDVorhanden'First = StadtDatentypen.GebäudeID (InteraktionAuswahl.MöglicheBauoptionen (AnfangSchleifenwert))
               then
                  GebäudeEnde := StadtDatentypen.GebäudeIDVorhanden'Last;
                  exit EndeSchleife;

               elsif
                 AnfangSchleifenwert = InteraktionAuswahl.BaulisteAnfang
               then
                  GebäudeEnde := StadtDatentypen.GebäudeIDVorhanden (InteraktionAuswahl.MöglicheBauoptionen (InteraktionAuswahl.BaulisteAnfang) - 1);
                  exit EndeSchleife;

               else
                  null;
               end if;

            end loop EndeSchleife;
      
            if
              Positive (GebäudeEnde) - InteraktionAuswahl.BaulisteEnde < 0
            then
               InteraktionAuswahl.MöglicheBauoptionen (InteraktionAuswahl.BaulisteAnfang .. InteraktionAuswahl.BaulisteEnde) := (others => AuswahlKonstanten.LeerAuswahl);
               GebäudeermittlungVorwärts (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
               return;
               
            else
               null;
            end if;

         when others =>
            GebäudeEnde := StadtDatentypen.GebäudeIDVorhanden'Last;
      end case;
      
      Baumöglichkeiten := InteraktionAuswahl.BaulisteEnde;
      InteraktionAuswahl.MöglicheBauoptionen (InteraktionAuswahl.BaulisteAnfang .. InteraktionAuswahl.BaulisteEnde) := (others => AuswahlKonstanten.LeerAuswahl);
                             
      GebäudeSchleife:
      for GebäudeSchleifenwert in reverse StadtDatentypen.GebäudeIDVorhanden'First .. GebäudeEnde loop
         
         if
           False = GebaeudeanforderungenLogik.AnforderungenErfüllt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                                     IDExtern                 => GebäudeSchleifenwert)
         then
            null;
         
         elsif
           Baumöglichkeiten >= InteraktionAuswahl.BaulisteAnfang
         then
            InteraktionAuswahl.MöglicheBauoptionen (Baumöglichkeiten) := Positive (GebäudeSchleifenwert);
            Baumöglichkeiten := Baumöglichkeiten - 1;
                  
         else
            InteraktionAuswahl.MöglicheBauoptionen (InteraktionAuswahl.BaulisteZurück) := AuswahlKonstanten.ErstAuswahl;
            InteraktionAuswahl.MöglicheBauoptionen (InteraktionAuswahl.BaulisteWeiter) := AuswahlKonstanten.ErstAuswahl;
            exit GebäudeSchleife;
         end if;
      
      end loop GebäudeSchleife;
      
   end GebäudeermittlungRückwärts;
   
   
   
   procedure MöglicheEinheitenErmitteln
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      ListenrichtungExtern : in SystemDatentypen.Erweiterter_Boolean_Enum)
   is begin
      
      case
        ListenrichtungExtern
      is
         when SystemDatentypen.Neutral_Enum | SystemDatentypen.False_Enum =>
            EinheitenermittlungVorwärts (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
            
         when SystemDatentypen.True_Enum =>
            EinheitenermittlungRückwärts (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      end case;
      
   end MöglicheEinheitenErmitteln;
   
   
   
   procedure EinheitenermittlungVorwärts
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is begin
                       
      case
        InteraktionAuswahl.MöglicheBauoptionen (InteraktionAuswahl.BaulisteWeiter)
      is
         when AuswahlKonstanten.ErstAuswahl =>
            AnfangSchleife:
            for AnfangSchleifenwert in InteraktionAuswahl.BaulisteAnfang .. InteraktionAuswahl.BaulisteEnde loop

               if
                 InteraktionAuswahl.MöglicheBauoptionen (AnfangSchleifenwert) = AuswahlKonstanten.LeerAuswahl
               then
                  EinheitenAnfang := EinheitenDatentypen.EinheitenIDVorhanden'First;
                  exit AnfangSchleife;

               elsif
                 EinheitenDatentypen.EinheitenIDVorhanden'Last = EinheitenDatentypen.EinheitenID (InteraktionAuswahl.MöglicheBauoptionen (AnfangSchleifenwert))
               then
                  EinheitenAnfang := EinheitenDatentypen.EinheitenIDVorhanden'First;
                  exit AnfangSchleife;

               elsif
                 AnfangSchleifenwert = InteraktionAuswahl.BaulisteEnde
               then
                  EinheitenAnfang := EinheitenDatentypen.EinheitenIDVorhanden (InteraktionAuswahl.MöglicheBauoptionen (InteraktionAuswahl.BaulisteEnde) + 1);
                  exit AnfangSchleife;

               else
                  null;
               end if;

            end loop AnfangSchleife;

         when others =>
            EinheitenAnfang := EinheitenDatentypen.EinheitenIDVorhanden'First;
      end case;
      
      Baumöglichkeiten := InteraktionAuswahl.BaulisteAnfang;
      InteraktionAuswahl.MöglicheBauoptionen (InteraktionAuswahl.BaulisteAnfang .. InteraktionAuswahl.BaulisteEnde) := (others => AuswahlKonstanten.LeerAuswahl);
      
      EinheitenSchleife:
      for EinheitSchleifenwert in EinheitenAnfang .. EinheitenDatentypen.EinheitenIDVorhanden'Last loop
         
         if
           False = EinheitenanforderungenLogik.AnforderungenErfüllt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                                      IDExtern                 => EinheitSchleifenwert)
         then
            null;
         
         elsif
           Baumöglichkeiten <= InteraktionAuswahl.BaulisteEnde
         then
            InteraktionAuswahl.MöglicheBauoptionen (Baumöglichkeiten) := Positive (EinheitSchleifenwert);
            Baumöglichkeiten := Baumöglichkeiten + 1;
                  
         else
            InteraktionAuswahl.MöglicheBauoptionen (InteraktionAuswahl.BaulisteZurück) := AuswahlKonstanten.ErstAuswahl;
            InteraktionAuswahl.MöglicheBauoptionen (InteraktionAuswahl.BaulisteWeiter) := AuswahlKonstanten.ErstAuswahl;
            exit EinheitenSchleife;
         end if;
      
      end loop EinheitenSchleife;
      
   end EinheitenermittlungVorwärts;
   
   
   
   procedure EinheitenermittlungRückwärts
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is begin
                  
      case
        InteraktionAuswahl.MöglicheBauoptionen (InteraktionAuswahl.BaulisteZurück)
      is
         when AuswahlKonstanten.ErstAuswahl =>
            EndeSchleife:
            for AnfangSchleifenwert in reverse InteraktionAuswahl.BaulisteAnfang .. InteraktionAuswahl.BaulisteEnde loop

               if
                 InteraktionAuswahl.MöglicheBauoptionen (AnfangSchleifenwert) = AuswahlKonstanten.LeerAuswahl
               then
                  EinheitenEnde := EinheitenDatentypen.EinheitenIDVorhanden'Last;
                  exit EndeSchleife;

               elsif
                 EinheitenDatentypen.EinheitenIDVorhanden'First = EinheitenDatentypen.EinheitenID (InteraktionAuswahl.MöglicheBauoptionen (AnfangSchleifenwert))
               then
                  EinheitenEnde := EinheitenDatentypen.EinheitenIDVorhanden'Last;
                  exit EndeSchleife;

               elsif
                 AnfangSchleifenwert = InteraktionAuswahl.BaulisteAnfang
               then
                  EinheitenEnde := EinheitenDatentypen.EinheitenIDVorhanden (InteraktionAuswahl.MöglicheBauoptionen (InteraktionAuswahl.BaulisteAnfang) - 1);
                  exit EndeSchleife;

               else
                  null;
               end if;

            end loop EndeSchleife;
      
            if
              Positive (EinheitenEnde) - InteraktionAuswahl.BaulisteEnde < 0
            then
               InteraktionAuswahl.MöglicheBauoptionen (InteraktionAuswahl.BaulisteAnfang .. InteraktionAuswahl.BaulisteEnde) := (others => AuswahlKonstanten.LeerAuswahl);
               EinheitenermittlungVorwärts (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
               return;
               
            else
               null;
            end if;

         when others =>
            EinheitenEnde := EinheitenDatentypen.EinheitenIDVorhanden'Last;
      end case;
      
      Baumöglichkeiten := InteraktionAuswahl.BaulisteEnde;
      InteraktionAuswahl.MöglicheBauoptionen (InteraktionAuswahl.BaulisteAnfang .. InteraktionAuswahl.BaulisteEnde) := (others => AuswahlKonstanten.LeerAuswahl);
                        
      
      EinheitenSchleife:
      for EinheitSchleifenwert in reverse EinheitenDatentypen.EinheitenIDVorhanden'First .. EinheitenEnde loop
         
         if
           False = EinheitenanforderungenLogik.AnforderungenErfüllt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                                      IDExtern                 => EinheitSchleifenwert)
         then
            null;
         
         elsif
           Baumöglichkeiten >= InteraktionAuswahl.BaulisteAnfang
         then
            InteraktionAuswahl.MöglicheBauoptionen (Baumöglichkeiten) := Positive (EinheitSchleifenwert);
            Baumöglichkeiten := Baumöglichkeiten - 1;
                  
         else
            InteraktionAuswahl.MöglicheBauoptionen (InteraktionAuswahl.BaulisteZurück) := AuswahlKonstanten.ErstAuswahl;
            InteraktionAuswahl.MöglicheBauoptionen (InteraktionAuswahl.BaulisteWeiter) := AuswahlKonstanten.ErstAuswahl;
            exit EinheitenSchleife;
         end if;
      
      end loop EinheitenSchleife;
      
   end EinheitenermittlungRückwärts;

end StadtbausystemLogik;
