with WichtigesRecordKonstanten;
with SpielVariablen;

package body SchreibeZeiger is

   procedure KoordinatenAktuell
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
   is begin
      
      SpielVariablen.Spielzeiger (SpeziesExtern).KoordinatenAktuell := KoordinatenExtern;
      
   end KoordinatenAktuell;
   
   
   
   procedure EbeneAktuell
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      EbeneExtern : in KartenDatentypen.EbeneVorhanden)
   is begin
      
      SpielVariablen.Spielzeiger (SpeziesExtern).KoordinatenAktuell.Ebene := EbeneExtern;
      
   end EbeneAktuell;
   
   

   procedure KoordinatenAlt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
   is begin
      
      SpielVariablen.Spielzeiger (SpeziesExtern).KoordinatenAlt := KoordinatenExtern;
      
   end KoordinatenAlt;
   
   
   
   procedure EbeneAlt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      EbeneExtern : in KartenDatentypen.EbeneVorhanden)
   is begin
      
      SpielVariablen.Spielzeiger (SpeziesExtern).KoordinatenAlt.Ebene := EbeneExtern;
      
   end EbeneAlt;
   
   
   
   procedure Standardeinstellungen
   is begin
      
      SpielVariablen.Spielzeiger := (others => WichtigesRecordKonstanten.LeerZeiger);
      
   end Standardeinstellungen;
   
   
   
   procedure GanzerEintrag
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      EintragExtern : in KartenRecords.ZeigerRecord)
   is begin
      
      SpielVariablen.Spielzeiger (SpeziesExtern) := EintragExtern;
      
   end GanzerEintrag;

end SchreibeZeiger;
