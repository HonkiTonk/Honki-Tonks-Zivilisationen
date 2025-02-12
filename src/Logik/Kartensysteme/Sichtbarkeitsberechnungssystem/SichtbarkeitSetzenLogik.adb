with SpeziesKonstanten;
with SystemDatentypen;

with LeseWeltkarte;
with SchreibeWeltkarte;

with EinheitSuchenLogik;
with KennenlernenLogik;
with MeldungssystemHTSEB;

package body SichtbarkeitSetzenLogik is

   -- Sollte man von Oben auch den Anfang der Unterflächenlandfelder sehen oder die so schwarz lassen? äöü
   -- Beziehungsweise auch umgekehrt? äöü
   -- Sollte man von der Unterfläche auch den Himmel sehen können? äöü
   procedure EbenenBerechnungen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
   is begin
      
      Basisgrund := LeseWeltkarte.Basisgrund (KoordinatenExtern => KoordinatenExtern);
      
      case
        KoordinatenExtern.Ebene
      is
         when KartenKonstanten.OberflächeKonstante =>
            if
              Basisgrund in KartengrundDatentypen.Basisgrund_Oberfläche_Wasser_Enum'Range
            then
               EbeneAnfang := KartenKonstanten.UnterflächeKonstante;
               
            else
               EbeneAnfang := KartenKonstanten.OberflächeKonstante;
            end if;
            
            EbeneEnde := KartenKonstanten.HimmelKonstante;
            
         when KartenKonstanten.HimmelKonstante =>
            EbeneAnfang := KartenKonstanten.OberflächeKonstante;
            EbeneEnde := KartenKonstanten.WeltraumKonstante;
            
         when KartenKonstanten.WeltraumKonstante =>
            EbeneAnfang := KartenKonstanten.HimmelKonstante;
            EbeneEnde := KartenKonstanten.WeltraumKonstante;
            
         when KartenKonstanten.UnterflächeKonstante =>
            EbeneAnfang := KartenKonstanten.UnterflächeKonstante;
            
            if
              Basisgrund in KartengrundDatentypen.Basisgrund_Unterfläche_Wasser_Enum'Range
            then
               EbeneEnde := KartenKonstanten.OberflächeKonstante;
               
            else
               EbeneEnde := KartenKonstanten.UnterflächeKonstante;
            end if;
            
         when KartenKonstanten.PlaneteninneresKonstante =>
            EbeneAnfang := KartenKonstanten.PlaneteninneresKonstante;
            EbeneEnde := KartenKonstanten.PlaneteninneresKonstante;
            
         when others =>
            MeldungssystemHTSEB.Logik (MeldungExtern => "SichtbarkeitSetzenLogik.EbenenBerechnungen: Ungültige Ebene: " & KoordinatenExtern.Ebene'Wide_Wide_Image);
            return;
      end case;
      
      Ebene:
      for EbeneSchleifenwert in EbeneAnfang .. EbeneEnde loop
         
         SichtbarkeitSetzen (SpeziesExtern     => SpeziesExtern,
                             KoordinatenExtern => (EbeneSchleifenwert, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte));
         
      end loop Ebene;
      
   end EbenenBerechnungen;
   
   
   
   -- Prüft ob auf einem neu aufgedecktem Feld sich eine fremde Stadt/Einheit befindet und stellt entsprechend Kontakt her.
   -- Anders als die Berechnung in BewegungsberechnungLogik, wo geprüft wird ob die Einheit jetzt auf einem Feld steht welches von einer fremden Spezies bereits aufgedeckt wurde.
   procedure SichtbarkeitSetzen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
   is
      use type SpeziesDatentypen.Spezies_Enum;
   begin
            
      case
        LeseWeltkarte.Sichtbar (KoordinatenExtern => KoordinatenExtern,
                                SpeziesExtern     => SpeziesExtern)
      is
         when True =>
            return;
            
         when False =>
            SchreibeWeltkarte.Sichtbar (KoordinatenExtern => KoordinatenExtern,
                                        SpeziesExtern     => SpeziesExtern,
                                        SichtbarExtern    => True);
      end case;
      
      FremdeEinheit := EinheitSuchenLogik.KoordinatenEinheitOhneSpezielleSpeziesSuchen (SpeziesExtern     => SpeziesExtern,
                                                                                        KoordinatenExtern => KoordinatenExtern,
                                                                                        TaskExtern        => SystemDatentypen.Logik_Task_Enum);
      
      case
        FremdeEinheit.Spezies
      is
         when SpeziesKonstanten.LeerSpezies =>
            null;
            
         when others =>
            KennenlernenLogik.Erstkontakt (EigeneSpeziesExtern => SpeziesExtern,
                                           FremdeSpeziesExtern => FremdeEinheit.Spezies);
            return;
      end case;
      
      FremdeStadt := LeseWeltkarte.StadtbelegungGrund (KoordinatenExtern => KoordinatenExtern);
      
      if
        FremdeStadt.Spezies = SpeziesKonstanten.LeerSpezies
        or
          FremdeStadt.Spezies = SpeziesExtern
      then
         null;
            
      else
         KennenlernenLogik.Erstkontakt (EigeneSpeziesExtern => SpeziesExtern,
                                        FremdeSpeziesExtern => FremdeStadt.Spezies);
      end if;
      
   end SichtbarkeitSetzen;

end SichtbarkeitSetzenLogik;
