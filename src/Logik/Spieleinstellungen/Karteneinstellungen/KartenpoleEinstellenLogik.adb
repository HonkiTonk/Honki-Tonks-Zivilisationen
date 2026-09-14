with MeldungssystemHTSEB;

with MenueDatentypen;
with KartenartDatentypen;
with KartenRecordKonstanten;
with TextnummernKonstanten;
with KartengeneratorRecordKonstanten;

with AuswahlaufteilungLogik;
with KartengeneratorVariablenLogik;
with KartentestsLogik;
with ZufallsgeneratorenSpieleinstellungenLogik;
with ZahleneingabeLogik;

-- Die Zugriffe auf KartengeneratorVariablenLogik mal in eigene Lese/Schreibefunktionen packen. äöü
package body KartenpoleEinstellenLogik is
   
   procedure Kartenpole
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
               MeldungssystemHTSEB.Logik (MeldungExtern => "KartenpoleEinstellenLogik.Kartenpole: Falsche Auswahl: " & KartenpoleAuswahl'Wide_Wide_Image);
         end case;
         
      end loop KartenpoleSchleife;
      
   end Kartenpole;
   
   
   
   function SenkrechtePolgrößen
     return KartenDatentypen.SenkrechteNatural
   is
      use type KartenDatentypen.SenkrechteBasis;
   begin
      
      BenutzerdefinierteGröße := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => 0,
                                                                     ZahlenMaximumExtern => Positive (KartengeneratorVariablenLogik.Kartenparameter.Kartengröße.Senkrechte / 2),
                                                                     WelcheFrageExtern   => TextnummernKonstanten.FrageEisschicht);

      
      -- Sollte man bei Abbruch nicht besser den aktuellen Wert zurück geben? äöü
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
      use type KartenDatentypen.WaagerechteBasis;
   begin
      
      BenutzerdefinierteGröße := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => 0,
                                                                     ZahlenMaximumExtern => Positive (KartengeneratorVariablenLogik.Kartenparameter.Kartengröße.Waagerechte / 2),
                                                                     WelcheFrageExtern   => TextnummernKonstanten.FrageEisschicht);
      
      -- Sollte man bei Abbruch nicht besser den aktuellen Wert zurück geben? äöü
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

end KartenpoleEinstellenLogik;
