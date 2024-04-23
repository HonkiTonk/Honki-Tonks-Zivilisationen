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
with InteraktionAuswahl;
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
            MöglicheGebäudeErmitteln (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
            
         when StadtDatentypen.Einheitenart_Enum =>
            MöglicheEinheitenErmitteln (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
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
                        MöglicheGebäudeErmitteln (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
            
                     when StadtDatentypen.Einheitenart_Enum =>
                        MöglicheEinheitenErmitteln (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
                  end case;
                  
               elsif
                 AktuelleAuswahl.Bauauswahl = AuswahlKonstanten.LeerAuswahl
               then
                  null;
                  
               elsif
                 AktuelleAuswahl.Bauauswahl = InteraktionAuswahl.MöglicheBauoptionen'Last
               then
                  case
                    Grafiktask.WelchesBaumenü
                  is
                     when StadtDatentypen.Gebäudeart_Enum =>
                        MöglicheGebäudeErmitteln (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
            
                     when StadtDatentypen.Einheitenart_Enum =>
                        MöglicheEinheitenErmitteln (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
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
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is begin
      
      BaubareGebäude := 1;
      
      if
        InteraktionAuswahl.MöglicheBauoptionen (16) = -1
        and
          InteraktionAuswahl.MöglicheBauoptionen (15) = AuswahlKonstanten.LeerAuswahl
      then
         GebäudeAnfang := StadtDatentypen.GebäudeIDVorhanden'First;
         
      elsif
        InteraktionAuswahl.MöglicheBauoptionen (16) = -1
      then
         GebäudeAnfang := StadtDatentypen.GebäudeIDVorhanden (InteraktionAuswahl.MöglicheBauoptionen (15) + 1);
           
      else
         GebäudeAnfang := StadtDatentypen.GebäudeIDVorhanden'First;
      end if;
      
      InteraktionAuswahl.MöglicheBauoptionen (1 .. 15) := (others => AuswahlKonstanten.LeerAuswahl);
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in GebäudeAnfang .. StadtDatentypen.GebäudeIDVorhanden'Last loop
         
         if
           False = GebaeudeanforderungenLogik.AnforderungenErfüllt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                                     IDExtern                 => GebäudeSchleifenwert)
         then
            null;
            
         elsif
           BaubareGebäude <= 15
         then
            InteraktionAuswahl.MöglicheBauoptionen (BaubareGebäude) := Positive (GebäudeSchleifenwert);
            BaubareGebäude := BaubareGebäude + 1;
                  
         else
            InteraktionAuswahl.MöglicheBauoptionen (InteraktionAuswahl.MöglicheBauoptionen'Last) := -1;
            exit GebäudeSchleife;
         end if;
         
      end loop GebäudeSchleife;
      
   end MöglicheGebäudeErmitteln;
   
   
   
   procedure MöglicheEinheitenErmitteln
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is begin
      
      BaubareEinheiten := 1;
      
     -- case
     --   InteraktionAuswahl.MöglicheBauoptionen (16)
     -- is
     --    when -1 =>
      --      TestSchleife:
      --      for TestSchleifenwert in InteraktionAuswahl.MöglicheBauoptionen'First .. 15 loop
               
      --         if
      --           InteraktionAuswahl.MöglicheBauoptionen (TestSchleifenwert) = AuswahlKonstanten.LeerAuswahl
      ----         then
      --            EinheitenAnfang := EinheitenDatentypen.EinheitenIDVorhanden'First;
       --           exit TestSchleife;
                  
       --        elsif
      --           EinheitenDatentypen.EinheitenIDVorhanden'Last = EinheitenDatentypen.EinheitenID (InteraktionAuswahl.MöglicheBauoptionen (TestSchleifenwert))
       --        then
       ---           EinheitenAnfang := EinheitenDatentypen.EinheitenIDVorhanden'First;
       --           exit TestSchleife;
                  
        --       elsif
        --         TestSchleifenwert = 15
       --        then
       --           EinheitenAnfang := EinheitenDatentypen.EinheitenIDVorhanden (InteraktionAuswahl.MöglicheBauoptionen (15) + 1);
        --          exit TestSchleife;
                  
         --      else
         --         null;
        --       end if;
               
        --    end loop TestSchleife;

       --  when others =>
       --     EinheitenAnfang := EinheitenDatentypen.EinheitenIDVorhanden'First;
    --  end case;
      
      if
        InteraktionAuswahl.MöglicheBauoptionen (16) = -1
        and
          InteraktionAuswahl.MöglicheBauoptionen (15) = AuswahlKonstanten.LeerAuswahl
      then
         EinheitenAnfang := EinheitenDatentypen.EinheitenIDVorhanden'First;
         
      elsif
        InteraktionAuswahl.MöglicheBauoptionen (16) = -1
      then
         EinheitenAnfang := EinheitenDatentypen.EinheitenIDVorhanden (InteraktionAuswahl.MöglicheBauoptionen (15) + 1);
           
      else
         EinheitenAnfang := EinheitenDatentypen.EinheitenIDVorhanden'First;
      end if;
    
      InteraktionAuswahl.MöglicheBauoptionen (1 ..15) := (others => AuswahlKonstanten.LeerAuswahl);
      
      EinheitenSchleife:
      for EinheitSchleifenwert in EinheitenAnfang .. EinheitenDatentypen.EinheitenIDVorhanden'Last loop
         
         if
           False = EinheitenanforderungenLogik.AnforderungenErfüllt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                                      IDExtern                 => EinheitSchleifenwert)
         then
            null;
         
         elsif
           BaubareEinheiten <= 15
         then
            InteraktionAuswahl.MöglicheBauoptionen (BaubareEinheiten) := Positive (EinheitSchleifenwert);
            BaubareEinheiten := BaubareEinheiten + 1;
                  
         else
            InteraktionAuswahl.MöglicheBauoptionen (InteraktionAuswahl.MöglicheBauoptionen'Last) := -1;
            exit EinheitenSchleife;
         end if;
      
      end loop EinheitenSchleife;
      
   end MöglicheEinheitenErmitteln;

end StadtbausystemLogik;
