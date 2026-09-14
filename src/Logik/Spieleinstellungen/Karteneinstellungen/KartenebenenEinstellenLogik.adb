with MeldungssystemHTSEB;

with KartenDatentypen;
with MenueDatentypen;
with KartenRecordKonstanten;
with KartenKonstanten;
with SpeziesDatentypen;

with SchreibeSpeziesbelegung;

with AuswahlaufteilungLogik;
with KartengeneratorVariablenLogik;
with ZufallsgeneratorenSpieleinstellungenLogik;

package body KartenebenenEinstellenLogik is
   
   procedure Kartenebene
   is begin
      
      KartenebeneSchleife:
      loop
         
         KartenebeneAuswahl := AuswahlaufteilungLogik.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Kartenebene_Menü_Enum);
         
         -- Anfang -2 .. 2 Ende
         case
           KartenebeneAuswahl
         is
            when RueckgabeDatentypen.Kartenebenen_Enum'Range =>
               KartengeneratorVariablenLogik.Kartenparameter.Kartenebene := KartenebenenTests (EingabeExtern => KartenebeneAuswahl);
               SpeziesTests (EbenenExtern => KartengeneratorVariablenLogik.Kartenparameter.Kartenebene);
                 
            when RueckgabeDatentypen.Auswahl_Sechs_Enum =>
               KartengeneratorVariablenLogik.Kartenparameter.Kartenebene := KartenRecordKonstanten.StandardKartenebenen;
               
            when RueckgabeDatentypen.Auswahl_Sieben_Enum =>
               KartengeneratorVariablenLogik.Kartenparameter.Kartenebene := ZufallsgeneratorenSpieleinstellungenLogik.ZufälligeKartenebenen;
               SpeziesTests (EbenenExtern => KartengeneratorVariablenLogik.Kartenparameter.Kartenebene);
               
            when RueckgabeDatentypen.Fertig_Enum | RueckgabeDatentypen.Zurück_Enum =>
               return;
               
            when others =>
               MeldungssystemHTSEB.Logik (MeldungExtern => "KartenebenenEinstellenLogik.Kartenebene: Falsche Auswahl: " & KartenebeneAuswahl'Wide_Wide_Image);
         end case;
         
      end loop KartenebeneSchleife;
      
   end Kartenebene;
   
   
   
   function KartenebenenTests
     (EingabeExtern : in RueckgabeDatentypen.Kartenebenen_Enum)
      return KartenRecords.KartenebenenVorhandenRecord
   is
      use type KartenDatentypen.EbeneVorhanden;
   begin
      
      Ebene := (EbeneAnfang => KartengeneratorVariablenLogik.Kartenparameter.Kartenebene.EbeneAnfang,
                EbeneEnde   => KartengeneratorVariablenLogik.Kartenparameter.Kartenebene.EbeneEnde);
      
      case
        EingabeExtern
      is
         when RueckgabeDatentypen.Auswahl_Eins_Enum =>
            if
              Ebene.EbeneEnde = KartenKonstanten.OrbitKonstante
            then
               Ebene.EbeneEnde := KartenKonstanten.HimmelKonstante;
                  
            else
               Ebene.EbeneEnde := KartenKonstanten.OrbitKonstante;
            end if;
               
         when RueckgabeDatentypen.Auswahl_Zwei_Enum =>
            if
              Ebene.EbeneEnde = KartenKonstanten.HimmelKonstante
            then
               Ebene.EbeneEnde := KartenKonstanten.OberflächeKonstante;
                  
            else
               Ebene.EbeneEnde := KartenKonstanten.HimmelKonstante;
            end if;
               
         when RueckgabeDatentypen.Auswahl_Drei_Enum =>
            if
              Ebene.EbeneEnde = KartenKonstanten.OberflächeKonstante
              and
                Ebene.EbeneAnfang <= KartenKonstanten.UnterflächeKonstante
            then
               Ebene.EbeneEnde := KartenKonstanten.UnterflächeKonstante;
                  
            elsif
              Ebene.EbeneEnde = KartenKonstanten.OberflächeKonstante
              and
                Ebene.EbeneAnfang > KartenKonstanten.UnterflächeKonstante
            then
               Ebene.EbeneEnde := KartenKonstanten.UnterflächeKonstante;
               Ebene.EbeneAnfang := KartenKonstanten.UnterflächeKonstante;
                    
            else
               Ebene.EbeneEnde := KartenKonstanten.OberflächeKonstante;
            end if;
               
         when RueckgabeDatentypen.Auswahl_Vier_Enum =>
            if
              Ebene.EbeneAnfang = KartenKonstanten.UnterflächeKonstante
              and
                Ebene.EbeneEnde > KartenKonstanten.UnterflächeKonstante
            then
               Ebene.EbeneAnfang := KartenKonstanten.OberflächeKonstante;
                  
            elsif
              Ebene.EbeneAnfang = KartenKonstanten.UnterflächeKonstante
              and
                Ebene.EbeneEnde = KartenKonstanten.UnterflächeKonstante
            then
               Ebene.EbeneAnfang := KartenKonstanten.OberflächeKonstante;
               Ebene.EbeneEnde := KartenKonstanten.OberflächeKonstante;
                  
            else
               Ebene.EbeneAnfang := KartenKonstanten.UnterflächeKonstante;
            end if;
               
         when RueckgabeDatentypen.Auswahl_Fünf_Enum =>
            if
              Ebene.EbeneAnfang = KartenKonstanten.KernKonstante
            then
               Ebene.EbeneAnfang := KartenKonstanten.UnterflächeKonstante;
                  
            else
               Ebene.EbeneAnfang := KartenKonstanten.KernKonstante;
            end if;
      end case;
      
      return Ebene;
      
   end KartenebenenTests;
   
   
   
   procedure SpeziesTests
     (EbenenExtern : in KartenRecords.KartenebenenVorhandenRecord)
   is
      use type KartenDatentypen.EbeneBasis;
   begin
      
      if
        EbenenExtern.EbeneAnfang > KartenKonstanten.UnterflächeKonstante
      then
         UnterflächenSchleife:
         for UnterflächenSchleifenwert in SpeziesDatentypen.Spezies_Unterfläche_Enum'Range loop
            
            SchreibeSpeziesbelegung.Belegung (SpeziesExtern  => UnterflächenSchleifenwert,
                                              BelegungExtern => SpeziesDatentypen.Leer_Spieler_Enum);
            
         end loop UnterflächenSchleife;
         
      elsif
        EbenenExtern.EbeneEnde < KartenKonstanten.OberflächeKonstante
      then
         OberflächenSchleife:
         for OberflächenSchleifenwert in SpeziesDatentypen.Spezies_Oberfläche_Enum'Range loop
            
            SchreibeSpeziesbelegung.Belegung (SpeziesExtern  => OberflächenSchleifenwert,
                                              BelegungExtern => SpeziesDatentypen.Leer_Spieler_Enum);
            
         end loop OberflächenSchleife;
         
      else
         null;
      end if;
      
   end SpeziesTests;

end KartenebenenEinstellenLogik;
