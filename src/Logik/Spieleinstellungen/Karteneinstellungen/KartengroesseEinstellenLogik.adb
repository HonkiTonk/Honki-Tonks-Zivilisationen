with MenueDatentypen;
with TextnummernKonstanten;
with KartenKonstanten;

with LeseWeltkarteneinstellungen;

with ZahleneingabeLogik;
with ZufallsgeneratorenSpieleinstellungenLogik;
with AuswahlaufteilungLogik;
with MeldungssystemHTSEB;
with KartengeneratorVariablenLogik;
with KartentestsLogik;

-- Die ganzen Zugriffe auf KartengeneratorVariablenLogik auch mal in Lese/Schreibevariablen packen. äöü
package body KartengroesseEinstellenLogik is

   procedure Kartengröße
   is begin
            
      KartengrößeSchleife:
      loop
         
         KartengrößeAuswahl := AuswahlaufteilungLogik.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Kartengröße_Menü_Enum);
                  
         case
           KartengrößeAuswahl
         is
            when RueckgabeDatentypen.Kartengrößen_Standard_Enum'Range =>
               KartengeneratorVariablenLogik.KartengrößeSchreiben (GrößeExtern => KartenKonstanten.StandardKartengrößen (KartengrößeAuswahl));

            when RueckgabeDatentypen.Auswahl_Elf_Enum =>
               KartengeneratorVariablenLogik.KartengrößeSchreiben (GrößeExtern => GrößeSelbstBestimmen);
               
            when RueckgabeDatentypen.Auswahl_Zwölf_Enum =>
               KartengeneratorVariablenLogik.KartengrößeSchreiben (GrößeExtern => KartenKonstanten.StandardKartengrößen (ZufallsgeneratorenSpieleinstellungenLogik.ZufälligeVordefinierteKartengröße));
               
            when RueckgabeDatentypen.Auswahl_Dreizehn_Enum =>
               KartengeneratorVariablenLogik.KartengrößeSchreiben (GrößeExtern => ZufallsgeneratorenSpieleinstellungenLogik.ZufälligeKartengröße);
               
            when RueckgabeDatentypen.Fertig_Enum | RueckgabeDatentypen.Zurück_Enum =>
               return;
               
            when others =>
               MeldungssystemHTSEB.Logik (MeldungExtern => "KartengroesseEinstellenLogik.Kartengröße: Falsche Auswahl: " & KartengrößeAuswahl'Wide_Wide_Image);
         end case;

         KartentestsLogik.Größenanpassung;
         
      end loop KartengrößeSchleife;
      
   end Kartengröße;
   
   
   
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

end KartengroesseEinstellenLogik;
