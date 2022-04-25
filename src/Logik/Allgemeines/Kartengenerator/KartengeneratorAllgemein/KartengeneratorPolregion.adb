pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenGrundDatentypen; use KartenGrundDatentypen;
with KartenDatentypen; use KartenDatentypen;
with KartenRecordKonstanten;

with SchreibeKarten;

with Karten;

package body KartengeneratorPolregion is

   procedure PolregionGenerieren
   is
      
      task Norden;
      task Süden;
      task Westen;
      task Osten;
      
      task body Norden
      is begin
         
         PolregionNorden;
         
      end Norden;
      
      
      
      task body Süden
      is begin
         
         PolregionSüden;
         
      end Süden;
      
      
      
      task body Westen
      is begin
         
         PolregionWesten;
         
      end Westen;
      
      
      
      task body Osten
      is begin
         
         PolregionOsten;
         
      end Osten;
   
   begin
      
      null;
      
   end PolregionGenerieren;
   
   
   
   procedure PolregionNorden
   is begin
      
      case
        Karten.Kartenparameter.Kartenpole.YAchseNorden
      is
         when KartenDatentypen.Kartenpol_Nicht_Vorhanden_Enum =>
            return;
            
         when KartenDatentypen.Kartenpol_Vorhanden_Enum =>
            null;
      end case;
      
      YAchseSchleife:
      for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) .. KartenRecordKonstanten.Eisrand (Karten.Kartenparameter.Kartengröße) loop
         XAchseSchleife:
         for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchsenGröße loop
            
            SchreibeKarten.Grund (KoordinatenExtern => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                  GrundExtern       => KartenGrundDatentypen.Eis_Enum);
            
            SchreibeKarten.Grund (KoordinatenExtern => (-1, YAchseSchleifenwert, XAchseSchleifenwert),
                                  GrundExtern       => KartenGrundDatentypen.Unterwasser_Eis_Enum);
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end PolregionNorden;
   
   
   
   procedure PolregionSüden
   is begin
      
      case
        Karten.Kartenparameter.Kartenpole.YAchseSüden
      is
         when KartenDatentypen.Kartenpol_Nicht_Vorhanden_Enum =>
            return;
            
         when KartenDatentypen.Kartenpol_Vorhanden_Enum =>
            null;
      end case;
      
      -- Hier ist + 1 nötig, da er nicht wie auf der anderen Polseite bis zu dem Punkt loopt sondern eins weiter.
      case
        KartenRecordKonstanten.Eisrand (Karten.Kartenparameter.Kartengröße)
      is
         when KartenDatentypen.KartenfeldPositivMitNullwert'First =>
            SüdpolSchleifenkorrektur := KartenDatentypen.KartenfeldPositivMitNullwert'First;
            
         when others =>
            SüdpolSchleifenkorrektur := 1;
      end case;

      YAchseSchleife:
      for YAchseSchleifenwert in Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchsenGröße - KartenRecordKonstanten.Eisrand (Karten.Kartenparameter.Kartengröße) + SüdpolSchleifenkorrektur
        .. Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchsenGröße
      loop
         XAchseSchleife:
         for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchsenGröße loop
            
            SchreibeKarten.Grund (KoordinatenExtern => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                  GrundExtern       => KartenGrundDatentypen.Eis_Enum);
            
            SchreibeKarten.Grund (KoordinatenExtern => (-1, YAchseSchleifenwert, XAchseSchleifenwert),
                                  GrundExtern       => KartenGrundDatentypen.Unterwasser_Eis_Enum);
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end PolregionSüden;
   
   
   
   procedure PolregionWesten
   is begin
      
      case
        Karten.Kartenparameter.Kartenpole.XAchseWesten
      is
         when KartenDatentypen.Kartenpol_Nicht_Vorhanden_Enum =>
            return;
            
         when KartenDatentypen.Kartenpol_Vorhanden_Enum =>
            null;
      end case;
      
      YAchseSchleife:
      for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchsenGröße loop
         XAchseSchleife:
         for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. KartenRecordKonstanten.Eisrand (Karten.Kartenparameter.Kartengröße) loop
            
            SchreibeKarten.Grund (KoordinatenExtern => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                  GrundExtern       => KartenGrundDatentypen.Eis_Enum);
            
            SchreibeKarten.Grund (KoordinatenExtern => (-1, YAchseSchleifenwert, XAchseSchleifenwert),
                                  GrundExtern       => KartenGrundDatentypen.Unterwasser_Eis_Enum);
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end PolregionWesten;
   
   
   
   procedure PolregionOsten
   is begin
      
      case
        Karten.Kartenparameter.Kartenpole.XAchseOsten
      is
         when KartenDatentypen.Kartenpol_Nicht_Vorhanden_Enum =>
            return;
            
         when KartenDatentypen.Kartenpol_Vorhanden_Enum =>
            null;
      end case;
      
      -- Hier ist + 1 nötig, da er nicht wie auf der anderen Polseite bis zu dem Punkt loopt sondern eins weiter.
      case
        KartenRecordKonstanten.Eisrand (Karten.Kartenparameter.Kartengröße)
      is
         when KartenDatentypen.KartenfeldPositivMitNullwert'First =>
            OstpolSchleifenkorrektur := KartenDatentypen.KartenfeldPositivMitNullwert'First;
            
         when others =>
            OstpolSchleifenkorrektur := 1;
      end case;
      
      YAchseSchleife:
      for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchsenGröße loop
         XAchseSchleife:
         for XAchseSchleifenwert in Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchsenGröße - KartenRecordKonstanten.Eisrand (Karten.Kartenparameter.Kartengröße) + OstpolSchleifenkorrektur
           .. Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchsenGröße
         loop
            
            SchreibeKarten.Grund (KoordinatenExtern => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                  GrundExtern       => KartenGrundDatentypen.Eis_Enum);
            
            SchreibeKarten.Grund (KoordinatenExtern => (-1, YAchseSchleifenwert, XAchseSchleifenwert),
                                  GrundExtern       => KartenGrundDatentypen.Unterwasser_Eis_Enum);
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end PolregionOsten;

end KartengeneratorPolregion;
