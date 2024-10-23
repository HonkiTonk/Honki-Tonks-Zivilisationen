with SpeziesDatentypen;
with KartenRecords;
with KartenDatentypen;

with LeseWeltkarteneinstellungen;

package SchreibeCursor is
   pragma Elaborate_Body;
   use type KartenDatentypen.Senkrechte;
   use type KartenDatentypen.Waagerechte;

   procedure KoordinatenAktuell
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   pragma Inline (KoordinatenAktuell);
   
   procedure EbeneAktuell
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      EbeneExtern : in KartenDatentypen.EbeneVorhanden);
   pragma Inline (EbeneAktuell);

   procedure KoordinatenAlt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   pragma Inline (KoordinatenAlt);
   
   procedure EbeneAlt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      EbeneExtern : in KartenDatentypen.EbeneVorhanden);
   pragma Inline (EbeneAlt);
   
   procedure Standardeinstellungen;
   pragma Inline (Standardeinstellungen);
   
   procedure GanzerEintrag
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      EintragExtern : in KartenRecords.ZeigerRecord)
     with
       Pre => (
                 EintragExtern.KoordinatenAktuell.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 EintragExtern.KoordinatenAktuell.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
               and
                 EintragExtern.KoordinatenAlt.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 EintragExtern.KoordinatenAlt.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   pragma Inline (GanzerEintrag);

end SchreibeCursor;
