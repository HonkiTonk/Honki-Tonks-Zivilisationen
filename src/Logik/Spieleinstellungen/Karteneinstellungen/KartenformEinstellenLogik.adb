with MeldungssystemHTSEB;

with KartenartDatentypen;
with MenueDatentypen;
with KartenRecordKonstanten;

with AuswahlaufteilungLogik;
with KartengeneratorVariablenLogik;
with ZufallsgeneratorenSpieleinstellungenLogik;

package body KartenformEinstellenLogik is

   procedure Kartenform
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
               MeldungssystemHTSEB.Logik (MeldungExtern => "KartenformEinstellenLogik.Kartenform: Falsche Auswahl: " & KartenformAuswahl'Wide_Wide_Image);
         end case;

      end loop KartenformSchleife;
      
   end Kartenform;
   
   
   
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

end KartenformEinstellenLogik;
