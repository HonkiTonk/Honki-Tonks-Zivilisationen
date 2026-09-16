with MeldungssystemHTSEB;

with KartengeneratorRecordKonstanten;
with MenueDatentypen;
with KartenartDatentypen;
with TextnummernKonstanten;
with KartenDatentypen;
with KartenKonstanten;

with AuswahlaufteilungLogik;
with ZufallsgeneratorenSpieleinstellungenLogik;
with KartengeneratorVariablenLogik;
with ZahleneingabeLogik;

package body KartenartEinstellenLogik is

   procedure Kartenart
   is begin
            
      KartenartSchleife:
      loop

         KartenartAuswahl := AuswahlaufteilungLogik.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Kartenart_Menü_Enum);
         
         case
           KartenartAuswahl
         is
            when RueckgabeDatentypen.Auswahl_Eins_Enum =>
               KartengeneratorVariablenLogik.KartenartSchreiben (ArtExtern => KartenartDatentypen.Kartenart_Inseln_Enum);
               
            when RueckgabeDatentypen.Auswahl_Zwei_Enum =>
               KartengeneratorVariablenLogik.KartenartSchreiben (ArtExtern => KartenartDatentypen.Kartenart_Kontinente_Enum);
               
            when RueckgabeDatentypen.Auswahl_Drei_Enum =>
               KartengeneratorVariablenLogik.KartenartSchreiben (ArtExtern => KartenartDatentypen.Kartenart_Pangäa_Enum);
               
            when RueckgabeDatentypen.Auswahl_Vier_Enum =>
               KartengeneratorVariablenLogik.KartenartSchreiben (ArtExtern => KartenartDatentypen.Kartenart_Nutzerdefiniert_Enum);
               KartenartNutzerdefinition;
               
            when RueckgabeDatentypen.Auswahl_Fünf_Enum =>
               KartengeneratorVariablenLogik.KartenartSchreiben (ArtExtern => ZufallsgeneratorenSpieleinstellungenLogik.ZufälligeVordefinierteKartenart);
               
            when RueckgabeDatentypen.Auswahl_Sechs_Enum =>
               KartengeneratorVariablenLogik.KartenartSchreiben (ArtExtern => KartenartDatentypen.Kartenart_Nutzerdefiniert_Enum);
               ZufallsgeneratorenSpieleinstellungenLogik.ZufälligeKartenart;
               
            when RueckgabeDatentypen.Auswahl_Sieben_Enum =>
               KartenartStandard;
               
            when RueckgabeDatentypen.Fertig_Enum | RueckgabeDatentypen.Zurück_Enum =>
               exit KartenartSchleife;
               
            when others =>
               MeldungssystemHTSEB.Logik (MeldungExtern => "KartenartEinstellenLogik.Kartenart: Falsche Auswahl: " & KartenartAuswahl'Wide_Wide_Image);
         end case;
                      
      end loop KartenartSchleife;
      
      case
        KartengeneratorVariablenLogik.KartenartLesen
      is
         when KartenartDatentypen.Kartenart_Nutzerdefiniert_Enum =>
            null;
            
         when others =>
            KartengeneratorVariablenLogik.LandgrößenSchreiben (GrößeExtern => KartengeneratorRecordKonstanten.Kartenartgrößen (KartengeneratorVariablenLogik.KartenartLesen));
      end case;
      
   end Kartenart;
   
   
   
   procedure KartenartNutzerdefinition
   is begin
      
      BenutzerdefinierteKartenart := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => 1,
                                                                       ZahlenMaximumExtern => Positive (KartengeneratorVariablenLogik.KartengrößeLesen.Senkrechte),
                                                                       WelcheFrageExtern   => TextnummernKonstanten.FrageMinimaleLandhöhe);
      
      case
        BenutzerdefinierteKartenart.ErfolgreichAbbruch
      is
         when False =>
            KartenartStandard;
            return;
            
         when True =>
            Größeneingabe.MinimaleSenkrechte := KartenDatentypen.SenkrechtePositiv (BenutzerdefinierteKartenart.EingegebeneZahl);
            ZwischenwertKartenart := BenutzerdefinierteKartenart.EingegebeneZahl;
      end case;
            
      BenutzerdefinierteKartenart := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => ZwischenwertKartenart,
                                                                       ZahlenMaximumExtern => Positive (KartengeneratorVariablenLogik.KartengrößeLesen.Senkrechte),
                                                                       WelcheFrageExtern   => TextnummernKonstanten.FrageMaximaleLandhöhe);
      
      case
        BenutzerdefinierteKartenart.ErfolgreichAbbruch
      is
         when False =>
            KartenartStandard;
            return;
            
         when True =>
            Größeneingabe.MaximaleSenkrechte := KartenDatentypen.SenkrechtePositiv (BenutzerdefinierteKartenart.EingegebeneZahl);
      end case;
      
      
      
      BenutzerdefinierteKartenart := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => 1,
                                                                       ZahlenMaximumExtern => Positive (KartengeneratorVariablenLogik.KartengrößeLesen.Waagerechte),
                                                                       WelcheFrageExtern   => TextnummernKonstanten.FrageMinimaleLandbreite);
      
      case
        BenutzerdefinierteKartenart.ErfolgreichAbbruch
      is
         when False =>
            KartenartStandard;
            return;
            
         when True =>
            Größeneingabe.MinimaleWaagerechte := KartenDatentypen.WaagerechtePositiv (BenutzerdefinierteKartenart.EingegebeneZahl);
            ZwischenwertKartenart := BenutzerdefinierteKartenart.EingegebeneZahl;
      end case;
            
      BenutzerdefinierteKartenart := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => ZwischenwertKartenart,
                                                                       ZahlenMaximumExtern => Positive (KartengeneratorVariablenLogik.KartengrößeLesen.Waagerechte),
                                                                       WelcheFrageExtern   => TextnummernKonstanten.FrageMaximaleLandbreite);
      
      case
        BenutzerdefinierteKartenart.ErfolgreichAbbruch
      is
         when False =>
            KartenartStandard;
            
         when True =>
            Größeneingabe.MaximaleWaagerechte := KartenDatentypen.WaagerechtePositiv (BenutzerdefinierteKartenart.EingegebeneZahl);
            KartengeneratorVariablenLogik.LandgrößenSchreiben (GrößeExtern => Größeneingabe);
      end case;
      
   end KartenartNutzerdefinition;



   procedure KartenartStandard
   is begin

      KartengeneratorVariablenLogik.KartenartSchreiben (ArtExtern => KartenKonstanten.StandardKartenart);
      KartengeneratorVariablenLogik.LandgrößenSchreiben (GrößeExtern => KartengeneratorRecordKonstanten.Kartenartgrößen (KartenartDatentypen.Kartenart_Kontinente_Enum));

   end KartenartStandard;

end KartenartEinstellenLogik;
