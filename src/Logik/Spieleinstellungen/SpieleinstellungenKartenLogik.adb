with KartenartDatentypen;
with MenueDatentypen;
with KartenRecordKonstanten;
with TextnummernKonstanten;
with KartenKonstanten;
with KartengeneratorRecordKonstanten;

with LeseWeltkarteneinstellungen;

with ZahleneingabeLogik;
with ZufallsgeneratorenSpieleinstellungenLogik;
with AuswahlaufteilungLogik;
with MeldungssystemHTB1;
with KartengeneratorVariablenLogik;
with UmwandlungenDatentypen;
with KartentestsLogik;

package body SpieleinstellungenKartenLogik is
   
   procedure KartenpoleWählen
   is begin
      
      KartenpoleSchleife:
      loop
         
         KartenpoleAuswahl := AuswahlaufteilungLogik.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Kartenpole_Menü_Enum);
         
         case
           KartenpoleAuswahl
         is
            when RueckgabeDatentypen.Auswahl_Eins_Enum =>
               KartengeneratorVariablenLogik.SenkrechtePolgrößen (KartenartDatentypen.Norden_Enum) := SenkrechtePolgrößen;
               KartengeneratorVariablenLogik.Kartenparameter.Kartenpole.Nordpol
                 := KartentestsLogik.SenkrechteKartenpolePrüfen (PolgrößeExtern => KartengeneratorVariablenLogik.SenkrechtePolgrößen (KartenartDatentypen.Norden_Enum));
               
            when RueckgabeDatentypen.Auswahl_Zwei_Enum =>
               KartengeneratorVariablenLogik.SenkrechtePolgrößen (KartenartDatentypen.Süden_Enum) := SenkrechtePolgrößen;
               KartengeneratorVariablenLogik.Kartenparameter.Kartenpole.Südpol
                 := KartentestsLogik.SenkrechteKartenpolePrüfen (PolgrößeExtern => KartengeneratorVariablenLogik.SenkrechtePolgrößen (KartenartDatentypen.Süden_Enum));
               
            when RueckgabeDatentypen.Auswahl_Drei_Enum =>
               KartengeneratorVariablenLogik.WaagerechtePolgrößen (KartenartDatentypen.Westen_Enum) := WaagerechtePolgrößen;
               KartengeneratorVariablenLogik.Kartenparameter.Kartenpole.Westpol
                 := KartentestsLogik.WaagerechteKartenpolePrüfen (PolgrößeExtern => KartengeneratorVariablenLogik.WaagerechtePolgrößen (KartenartDatentypen.Westen_Enum));
               
            when RueckgabeDatentypen.Auswahl_Vier_Enum =>
               KartengeneratorVariablenLogik.WaagerechtePolgrößen (KartenartDatentypen.Osten_Enum) := WaagerechtePolgrößen;
               KartengeneratorVariablenLogik.Kartenparameter.Kartenpole.Ostpol
                 := KartentestsLogik.WaagerechteKartenpolePrüfen (PolgrößeExtern => KartengeneratorVariablenLogik.WaagerechtePolgrößen (KartenartDatentypen.Osten_Enum));
               
            when RueckgabeDatentypen.Auswahl_Fünf_Enum =>
               ZufallsgeneratorenSpieleinstellungenLogik.ZufälligePole;
               
            when RueckgabeDatentypen.Auswahl_Sechs_Enum =>
               KartengeneratorVariablenLogik.Kartenparameter.Kartenpole := KartenRecordKonstanten.KartenpoleStandard;
               KartengeneratorVariablenLogik.SenkrechtePolgrößen := KartengeneratorRecordKonstanten.SenkrechterEisrand;
               
            when RueckgabeDatentypen.Fertig_Enum | RueckgabeDatentypen.Zurück_Enum =>
               return;
               
            when others =>
               MeldungssystemHTB1.Logik (MeldungExtern => "SpieleinstellungenKartenLogik.KartenpoleWählen: Falsche Auswahl: " & KartenpoleAuswahl'Wide_Wide_Image);
         end case;
         
      end loop KartenpoleSchleife;
      
   end KartenpoleWählen;
   
   
   
   function SenkrechtePolgrößen
     return KartenDatentypen.SenkrechteNatural
   is
      use type KartenDatentypen.Senkrechte;
   begin
      
      BenutzerdefinierteGröße := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => 0,
                                                                     ZahlenMaximumExtern => Positive (KartengeneratorVariablenLogik.Kartenparameter.Kartengröße.Senkrechte / 2),
                                                                     WelcheFrageExtern   => TextnummernKonstanten.FrageEisschicht);

      
      if
        BenutzerdefinierteGröße.ErfolgreichAbbruch = False
        or
          BenutzerdefinierteGröße.EingegebeneZahl = 0
      then
         return 0;
         
      else
         return KartenDatentypen.SenkrechteNatural (BenutzerdefinierteGröße.EingegebeneZahl);
      end if;
      
   end SenkrechtePolgrößen;
   
   
   
   function WaagerechtePolgrößen
     return KartenDatentypen.WaagerechteNatural
   is
      use type KartenDatentypen.Waagerechte;
   begin
      
      BenutzerdefinierteGröße := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => 0,
                                                                     ZahlenMaximumExtern => Positive (KartengeneratorVariablenLogik.Kartenparameter.Kartengröße.Waagerechte / 2),
                                                                     WelcheFrageExtern   => TextnummernKonstanten.FrageEisschicht);
      
      if
        BenutzerdefinierteGröße.ErfolgreichAbbruch = False
        or
          BenutzerdefinierteGröße.EingegebeneZahl = 0
      then
         return 0;
         
      else
         return KartenDatentypen.WaagerechteNatural (BenutzerdefinierteGröße.EingegebeneZahl);
      end if;
      
   end WaagerechtePolgrößen;
   
   

   procedure KartengrößeWählen
   is begin
            
      KartengrößeSchleife:
      loop
         
         KartengrößeAuswahl := AuswahlaufteilungLogik.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Kartengröße_Menü_Enum);
                  
         case
           KartengrößeAuswahl
         is
            when RueckgabeDatentypen.Kartengrößen_Standard_Enum'Range =>
               KartengeneratorVariablenLogik.Kartenparameter.Kartengröße := KartenKonstanten.StandardKartengrößen (KartengrößeAuswahl);

            when RueckgabeDatentypen.Auswahl_Zehn_Enum =>
               KartengeneratorVariablenLogik.Kartenparameter.Kartengröße := GrößeSelbstBestimmen;
               
            when RueckgabeDatentypen.Auswahl_Elf_Enum =>
               KartengeneratorVariablenLogik.Kartenparameter.Kartengröße := KartenKonstanten.StandardKartengrößen (ZufallsgeneratorenSpieleinstellungenLogik.ZufälligeVordefinierteKartengröße);
               
            when RueckgabeDatentypen.Auswahl_Zwölf_Enum =>
               KartengeneratorVariablenLogik.Kartenparameter.Kartengröße := ZufallsgeneratorenSpieleinstellungenLogik.ZufälligeKartengröße;
               
            when RueckgabeDatentypen.Fertig_Enum | RueckgabeDatentypen.Zurück_Enum =>
               return;
               
            when others =>
               MeldungssystemHTB1.Logik (MeldungExtern => "SpieleinstellungenKartenLogik.KartengrößeWählen: Falsche Auswahl: " & KartengrößeAuswahl'Wide_Wide_Image);
         end case;

         KartentestsLogik.Größenanpassung;
         
      end loop KartengrößeSchleife;
      
   end KartengrößeWählen;
   
   
   
   function GrößeSelbstBestimmen
     return KartenRecords.KartenfeldumgebungPositivRecord
   is begin
            
      BenutzerdefinierteGröße := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => Positive (KartenKonstanten.MinimaleKartengröße.Senkrechte),
                                                                     ZahlenMaximumExtern => Positive (KartenDatentypen.SenkrechtePositiv'Last),
                                                                     WelcheFrageExtern   => TextnummernKonstanten.FrageSenkrechtegrößeEingeben);
      case
        BenutzerdefinierteGröße.ErfolgreichAbbruch
      is
         when False =>
            return (LeseWeltkarteneinstellungen.Senkrechte, LeseWeltkarteneinstellungen.Waagerechte);
            
         when True =>
            null;
      end case;
      
      Senkrechte := KartenDatentypen.SenkrechtePositiv (BenutzerdefinierteGröße.EingegebeneZahl);
      
      BenutzerdefinierteGröße := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => Positive (KartenKonstanten.MinimaleKartengröße.Waagerechte),
                                                                     ZahlenMaximumExtern => Positive (KartenDatentypen.WaagerechtePositiv'Last),
                                                                     WelcheFrageExtern   => TextnummernKonstanten.FrageWaagerechtegrößeEingeben);
      
      case
        BenutzerdefinierteGröße.ErfolgreichAbbruch
      is
         when False =>
            return (LeseWeltkarteneinstellungen.Senkrechte, LeseWeltkarteneinstellungen.Waagerechte);
            
         when True =>
            Waagerechte := KartenDatentypen.WaagerechtePositiv (BenutzerdefinierteGröße.EingegebeneZahl);
      end case;
      
      return (Senkrechte, Waagerechte);
      
   end GrößeSelbstBestimmen;



   procedure KartenartWählen
   is begin
            
      KartenartSchleife:
      loop

         KartenartAuswahl := AuswahlaufteilungLogik.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Kartenart_Menü_Enum);
         
         case
           KartenartAuswahl
         is
            when RueckgabeDatentypen.Auswahl_Eins_Enum =>
               KartengeneratorVariablenLogik.Kartenparameter.Kartenart := KartenartDatentypen.Kartenart_Inseln_Enum;
               
            when RueckgabeDatentypen.Auswahl_Zwei_Enum =>
               KartengeneratorVariablenLogik.Kartenparameter.Kartenart := KartenartDatentypen.Kartenart_Kontinente_Enum;
               
            when RueckgabeDatentypen.Auswahl_Drei_Enum =>
               KartengeneratorVariablenLogik.Kartenparameter.Kartenart := KartenartDatentypen.Kartenart_Pangäa_Enum;
               
            when RueckgabeDatentypen.Auswahl_Vier_Enum =>
               KartengeneratorVariablenLogik.Kartenparameter.Kartenart := KartenartDatentypen.Kartenart_Nutzerdefiniert_Enum;
               KartenartNutzerdefinition;
               
            when RueckgabeDatentypen.Auswahl_Fünf_Enum =>
               KartengeneratorVariablenLogik.Kartenparameter.Kartenart := ZufallsgeneratorenSpieleinstellungenLogik.ZufälligeVordefinierteKartenart;
               
            when RueckgabeDatentypen.Auswahl_Sechs_Enum =>
               KartengeneratorVariablenLogik.Kartenparameter.Kartenart := KartenartDatentypen.Kartenart_Nutzerdefiniert_Enum;
               ZufallsgeneratorenSpieleinstellungenLogik.ZufälligeKartenart;
               
            when RueckgabeDatentypen.Auswahl_Sieben_Enum =>
               KartenartStandard;
               
            when RueckgabeDatentypen.Fertig_Enum | RueckgabeDatentypen.Zurück_Enum =>
               exit KartenartSchleife;
               
            when others =>
               MeldungssystemHTB1.Logik (MeldungExtern => "SpieleinstellungenKartenLogik.KartenartWählen: Falsche Auswahl: " & KartenartAuswahl'Wide_Wide_Image);
         end case;
                      
      end loop KartenartSchleife;
      
      case
        KartengeneratorVariablenLogik.Kartenparameter.Kartenart
      is
         when KartenartDatentypen.Kartenart_Nutzerdefiniert_Enum =>
            null;
            
         when others =>
            KartengeneratorVariablenLogik.Landgrößen := KartengeneratorRecordKonstanten.Kartenartgrößen (KartengeneratorVariablenLogik.Kartenparameter.Kartenart);
      end case;
      
   end KartenartWählen;
   
   
   
   procedure KartenartNutzerdefinition
   is begin
      
      BenutzerdefinierteKartenart := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => 1,
                                                                       ZahlenMaximumExtern => Positive (KartengeneratorVariablenLogik.Kartenparameter.Kartengröße.Senkrechte),
                                                                       WelcheFrageExtern   => TextnummernKonstanten.FrageMinimaleLandhöhe);
      
      case
        BenutzerdefinierteKartenart.ErfolgreichAbbruch
      is
         when False =>
            KartenartStandard;
            return;
            
         when True =>
            KartengeneratorVariablenLogik.Landgrößen.MinimaleSenkrechte := KartenDatentypen.SenkrechtePositiv (BenutzerdefinierteKartenart.EingegebeneZahl);
            ZwischenwertKartenart := BenutzerdefinierteKartenart.EingegebeneZahl;
      end case;
            
      BenutzerdefinierteKartenart := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => ZwischenwertKartenart,
                                                                       ZahlenMaximumExtern => Positive (KartengeneratorVariablenLogik.Kartenparameter.Kartengröße.Senkrechte),
                                                                       WelcheFrageExtern   => TextnummernKonstanten.FrageMaximaleLandhöhe);
      
      case
        BenutzerdefinierteKartenart.ErfolgreichAbbruch
      is
         when False =>
            KartenartStandard;
            return;
            
         when True =>
            KartengeneratorVariablenLogik.Landgrößen.MaximaleSenkrechte := KartenDatentypen.SenkrechtePositiv (BenutzerdefinierteKartenart.EingegebeneZahl);
      end case;
      
      
      
      BenutzerdefinierteKartenart := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => 1,
                                                                       ZahlenMaximumExtern => Positive (KartengeneratorVariablenLogik.Kartenparameter.Kartengröße.Waagerechte),
                                                                       WelcheFrageExtern   => TextnummernKonstanten.FrageMinimaleLandbreite);
      
      case
        BenutzerdefinierteKartenart.ErfolgreichAbbruch
      is
         when False =>
            KartenartStandard;
            return;
            
         when True =>
            KartengeneratorVariablenLogik.Landgrößen.MinimaleWaagerechte := KartenDatentypen.WaagerechtePositiv (BenutzerdefinierteKartenart.EingegebeneZahl);
            ZwischenwertKartenart := BenutzerdefinierteKartenart.EingegebeneZahl;
      end case;
            
      BenutzerdefinierteKartenart := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => ZwischenwertKartenart,
                                                                       ZahlenMaximumExtern => Positive (KartengeneratorVariablenLogik.Kartenparameter.Kartengröße.Waagerechte),
                                                                       WelcheFrageExtern   => TextnummernKonstanten.FrageMaximaleLandbreite);
      
      case
        BenutzerdefinierteKartenart.ErfolgreichAbbruch
      is
         when False =>
            KartenartStandard;
            
         when True =>
            KartengeneratorVariablenLogik.Landgrößen.MaximaleWaagerechte := KartenDatentypen.WaagerechtePositiv (BenutzerdefinierteKartenart.EingegebeneZahl);
      end case;
      
   end KartenartNutzerdefinition;



   procedure KartenartStandard
   is begin

      KartengeneratorVariablenLogik.Kartenparameter.Kartenart := KartenKonstanten.StandardKartenart;
      KartengeneratorVariablenLogik.Landgrößen := KartengeneratorRecordKonstanten.Kartenartgrößen (KartenartDatentypen.Kartenart_Kontinente_Enum);

   end KartenartStandard;
   
   
   
   procedure KartenformWählen
   is begin
      
      KartenformSchleife:
      loop

         KartenformAuswahl := AuswahlaufteilungLogik.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Kartenform_Menü_Enum);
         
         case
           KartenformAuswahl
         is
            when RueckgabeDatentypen.Kartenform_Enum'Range =>
               KartenformZuweisen (WelchEbeneExtern => KartenformAuswahl);
               
            when RueckgabeDatentypen.Auswahl_Sieben_Enum =>
               ZufallsgeneratorenSpieleinstellungenLogik.ZufälligeKartenform;
               
            when RueckgabeDatentypen.Auswahl_Acht_Enum =>
               KartengeneratorVariablenLogik.Kartenparameter.Kartenform := KartenRecordKonstanten.KartenformStandard;
               
            when RueckgabeDatentypen.Fertig_Enum | RueckgabeDatentypen.Zurück_Enum =>
               return;
               
            when others =>
               MeldungssystemHTB1.Logik (MeldungExtern => "SpieleinstellungenKartenLogik.KartenformWählen: Falsche Auswahl: " & KartenformAuswahl'Wide_Wide_Image);
         end case;

      end loop KartenformSchleife;
      
   end KartenformWählen;
   
   
   
   procedure KartenformZuweisen
     (WelchEbeneExtern : in RueckgabeDatentypen.Kartenform_Enum)
   is
      use type KartenartDatentypen.Kartenform_Enum;
   begin
      
      case
        WelchEbeneExtern
      is
         when RueckgabeDatentypen.Auswahl_Eins_Enum =>
            if
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.EbeneOben = KartenartDatentypen.Kartenform_Ebene_Einstellbar_Enum'Last
            then
               KartengeneratorVariablenLogik.Kartenparameter.Kartenform.EbeneOben := KartenartDatentypen.Kartenform_Ebene_Einstellbar_Enum'First;
               
            else
               KartengeneratorVariablenLogik.Kartenparameter.Kartenform.EbeneOben
                 := KartenartDatentypen.Kartenform_Ebene_Einstellbar_Enum'Val (KartenartDatentypen.Kartenform_Ebene_Einstellbar_Enum'Pos (KartengeneratorVariablenLogik.Kartenparameter.Kartenform.EbeneOben) + 1);
            end if;
            
         when RueckgabeDatentypen.Auswahl_Zwei_Enum =>
            if
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.EbeneUnten = KartenartDatentypen.Kartenform_Ebene_Einstellbar_Enum'Last
            then
               KartengeneratorVariablenLogik.Kartenparameter.Kartenform.EbeneUnten := KartenartDatentypen.Kartenform_Ebene_Einstellbar_Enum'First;
               
            else
               KartengeneratorVariablenLogik.Kartenparameter.Kartenform.EbeneUnten
                 := KartenartDatentypen.Kartenform_Ebene_Einstellbar_Enum'Val (KartenartDatentypen.Kartenform_Ebene_Einstellbar_Enum'Pos (KartengeneratorVariablenLogik.Kartenparameter.Kartenform.EbeneUnten) + 1);
            end if;
            
         when RueckgabeDatentypen.Auswahl_Drei_Enum =>
            if
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.SenkrechteNorden = KartenartDatentypen.Kartenform_Senkrechte_Einstellbar_Enum'Last
            then
               KartengeneratorVariablenLogik.Kartenparameter.Kartenform.SenkrechteNorden := KartenartDatentypen.Kartenform_Senkrechte_Einstellbar_Enum'First;
               
            else
               KartengeneratorVariablenLogik.Kartenparameter.Kartenform.SenkrechteNorden
                 := KartenartDatentypen.Kartenform_Senkrechte_Einstellbar_Enum'Val
                   (KartenartDatentypen.Kartenform_Senkrechte_Einstellbar_Enum'Pos (KartengeneratorVariablenLogik.Kartenparameter.Kartenform.SenkrechteNorden) + 1);
            end if;
            
         when RueckgabeDatentypen.Auswahl_Vier_Enum =>
            if
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.SenkrechteSüden = KartenartDatentypen.Kartenform_Senkrechte_Einstellbar_Enum'Last
            then
               KartengeneratorVariablenLogik.Kartenparameter.Kartenform.SenkrechteSüden := KartenartDatentypen.Kartenform_Senkrechte_Einstellbar_Enum'First;
               
            else
               KartengeneratorVariablenLogik.Kartenparameter.Kartenform.SenkrechteSüden
                 := KartenartDatentypen.Kartenform_Senkrechte_Einstellbar_Enum'Val
                   (KartenartDatentypen.Kartenform_Senkrechte_Einstellbar_Enum'Pos (KartengeneratorVariablenLogik.Kartenparameter.Kartenform.SenkrechteSüden) + 1);
            end if;
            
         when RueckgabeDatentypen.Auswahl_Fünf_Enum =>
            if
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.WaagerechteWesten = KartenartDatentypen.Kartenform_Waagerechte_Einstellbar_Enum'Last
            then
               KartengeneratorVariablenLogik.Kartenparameter.Kartenform.WaagerechteWesten := KartenartDatentypen.Kartenform_Waagerechte_Einstellbar_Enum'First;
               
            else
               KartengeneratorVariablenLogik.Kartenparameter.Kartenform.WaagerechteWesten
                 := KartenartDatentypen.Kartenform_Waagerechte_Einstellbar_Enum'Val
                   (KartenartDatentypen.Kartenform_Waagerechte_Einstellbar_Enum'Pos (KartengeneratorVariablenLogik.Kartenparameter.Kartenform.WaagerechteWesten) + 1);
            end if;
            
         when RueckgabeDatentypen.Auswahl_Sechs_Enum =>
            if
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.WaagerechteOsten = KartenartDatentypen.Kartenform_Waagerechte_Einstellbar_Enum'Last
            then
               KartengeneratorVariablenLogik.Kartenparameter.Kartenform.WaagerechteOsten := KartenartDatentypen.Kartenform_Waagerechte_Einstellbar_Enum'First;
               
            else
               KartengeneratorVariablenLogik.Kartenparameter.Kartenform.WaagerechteOsten
                 := KartenartDatentypen.Kartenform_Waagerechte_Einstellbar_Enum'Val
                   (KartenartDatentypen.Kartenform_Waagerechte_Einstellbar_Enum'Pos (KartengeneratorVariablenLogik.Kartenparameter.Kartenform.WaagerechteOsten) + 1);
            end if;
      end case;
      
   end KartenformZuweisen;



   -- Temperatur durch was anderes ersetzen, was mehr über die Kartenbeschaffenheit aussagt. äöü
   -- Oder drinnen lassen und weitere Einstellmöglichkeiten wie Gebirgigkeit einbauen? äöü
   procedure KartentemperaturWählen
   is begin
            
      KartentemperaturSchleife:
      loop

         KartentemperaturAuswahl := AuswahlaufteilungLogik.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Kartentemperatur_Menü_Enum);
                  
         case
           KartentemperaturAuswahl
         is
            when RueckgabeDatentypen.Kartentemperatur_Enum'Range =>
               KartengeneratorVariablenLogik.Kartenparameter.Kartentemperatur := UmwandlungenDatentypen.KartentemperaturrückgabeNachKartentemperatur (RückgabeExtern => KartentemperaturAuswahl);
               
            when RueckgabeDatentypen.Auswahl_Sechs_Enum =>
               KartengeneratorVariablenLogik.Kartenparameter.Kartentemperatur := ZufallsgeneratorenSpieleinstellungenLogik.ZufälligeKartentemperatur;
               
            when RueckgabeDatentypen.Fertig_Enum | RueckgabeDatentypen.Zurück_Enum =>
               return;
               
            when others =>
               MeldungssystemHTB1.Logik (MeldungExtern => "SpieleinstellungenKartenLogik.KartentemperaturWählen: Falsche Auswahl: " & KartentemperaturAuswahl'Wide_Wide_Image);
         end case;
         
      end loop KartentemperaturSchleife;
      
   end KartentemperaturWählen;
   
   
   
   procedure KartenressourcenWählen
   is begin
      
      KartenressourcenSchleife:
      loop

         KartenressourcenAuswahl := AuswahlaufteilungLogik.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Kartenressourcen_Menü_Enum);
         
         case
           KartenressourcenAuswahl
         is
            when RueckgabeDatentypen.Kartenressourcen_Enum'Range =>
               KartengeneratorVariablenLogik.Kartenparameter.Kartenressourcen := UmwandlungenDatentypen.KartenressourcenrückgabeNachKartenressource (RückgabeExtern => KartenressourcenAuswahl);
               
            when RueckgabeDatentypen.Auswahl_Sechs_Enum =>
               KartengeneratorVariablenLogik.Kartenparameter.Kartenressourcen := ZufallsgeneratorenSpieleinstellungenLogik.ZufälligeKartenressourcen;
               
            when RueckgabeDatentypen.Fertig_Enum | RueckgabeDatentypen.Zurück_Enum =>
               return;
               
            when others =>
               MeldungssystemHTB1.Logik (MeldungExtern => "SpieleinstellungenKartenLogik.KartenressourcenWählen: Falsche Auswahl: " & KartenressourcenAuswahl'Wide_Wide_Image);
         end case;
         
      end loop KartenressourcenSchleife;
      
   end KartenressourcenWählen;

end SpieleinstellungenKartenLogik;
