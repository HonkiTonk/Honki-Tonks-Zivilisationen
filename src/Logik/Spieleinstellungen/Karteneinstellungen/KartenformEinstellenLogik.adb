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
               KartengeneratorVariablenLogik.KartenformSchreiben (FormExtern => KartenRecordKonstanten.KartenformStandard);
               
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
      
      KartenformEingestellt := KartengeneratorVariablenLogik.KartenformLesen;
      
      case
        WelchEbeneExtern
      is
         when RueckgabeDatentypen.Auswahl_Eins_Enum =>
            if
              KartenformEingestellt.EbeneOben = KartenartDatentypen.Kartenform_Ebene_Einstellbar_Enum'Last
            then
               KartenformNeu.EbeneOben := KartenartDatentypen.Kartenform_Ebene_Einstellbar_Enum'First;
               
            else
               KartenformNeu.EbeneOben
                 := KartenartDatentypen.Kartenform_Ebene_Einstellbar_Enum'Val (KartenartDatentypen.Kartenform_Ebene_Einstellbar_Enum'Pos (KartengeneratorVariablenLogik.KartenformLesen.EbeneOben) + 1);
            end if;
            
         when RueckgabeDatentypen.Auswahl_Zwei_Enum =>
            if
             KartenformEingestellt.EbeneUnten = KartenartDatentypen.Kartenform_Ebene_Einstellbar_Enum'Last
            then
               KartenformNeu.EbeneUnten := KartenartDatentypen.Kartenform_Ebene_Einstellbar_Enum'First;
               
            else
               KartenformNeu.EbeneUnten
                 := KartenartDatentypen.Kartenform_Ebene_Einstellbar_Enum'Val (KartenartDatentypen.Kartenform_Ebene_Einstellbar_Enum'Pos (KartengeneratorVariablenLogik.KartenformLesen.EbeneUnten) + 1);
            end if;
            
         when RueckgabeDatentypen.Auswahl_Drei_Enum =>
            if
              KartenformEingestellt.SenkrechteNorden = KartenartDatentypen.Kartenform_Senkrechte_Einstellbar_Enum'Last
            then
               KartenformNeu.SenkrechteNorden := KartenartDatentypen.Kartenform_Senkrechte_Einstellbar_Enum'First;
               
            else
               KartenformNeu.SenkrechteNorden
                 := KartenartDatentypen.Kartenform_Senkrechte_Einstellbar_Enum'Val
                   (KartenartDatentypen.Kartenform_Senkrechte_Einstellbar_Enum'Pos (KartengeneratorVariablenLogik.KartenformLesen.SenkrechteNorden) + 1);
            end if;
            
         when RueckgabeDatentypen.Auswahl_Vier_Enum =>
            if
              KartenformEingestellt.SenkrechteSüden = KartenartDatentypen.Kartenform_Senkrechte_Einstellbar_Enum'Last
            then
               KartenformNeu.SenkrechteSüden := KartenartDatentypen.Kartenform_Senkrechte_Einstellbar_Enum'First;
               
            else
               KartenformNeu.SenkrechteSüden
                 := KartenartDatentypen.Kartenform_Senkrechte_Einstellbar_Enum'Val
                   (KartenartDatentypen.Kartenform_Senkrechte_Einstellbar_Enum'Pos (KartengeneratorVariablenLogik.KartenformLesen.SenkrechteSüden) + 1);
            end if;
            
         when RueckgabeDatentypen.Auswahl_Fünf_Enum =>
            if
              KartenformEingestellt.WaagerechteWesten = KartenartDatentypen.Kartenform_Waagerechte_Einstellbar_Enum'Last
            then
               KartenformNeu.WaagerechteWesten := KartenartDatentypen.Kartenform_Waagerechte_Einstellbar_Enum'First;
               
            else
               KartenformNeu.WaagerechteWesten
                 := KartenartDatentypen.Kartenform_Waagerechte_Einstellbar_Enum'Val
                   (KartenartDatentypen.Kartenform_Waagerechte_Einstellbar_Enum'Pos (KartengeneratorVariablenLogik.KartenformLesen.WaagerechteWesten) + 1);
            end if;
            
         when RueckgabeDatentypen.Auswahl_Sechs_Enum =>
            if
              KartenformEingestellt.WaagerechteOsten = KartenartDatentypen.Kartenform_Waagerechte_Einstellbar_Enum'Last
            then
               KartenformNeu.WaagerechteOsten := KartenartDatentypen.Kartenform_Waagerechte_Einstellbar_Enum'First;
               
            else
               KartenformNeu.WaagerechteOsten
                 := KartenartDatentypen.Kartenform_Waagerechte_Einstellbar_Enum'Val
                   (KartenartDatentypen.Kartenform_Waagerechte_Einstellbar_Enum'Pos (KartengeneratorVariablenLogik.KartenformLesen.WaagerechteOsten) + 1);
            end if;
      end case;
      
      KartengeneratorVariablenLogik.KartenformSchreiben (FormExtern => KartenformNeu);
      
   end KartenformZuweisen;

end KartenformEinstellenLogik;
