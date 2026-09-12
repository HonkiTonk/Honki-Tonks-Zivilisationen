private with SystemDatentypenHTSEB;

with KartenDatentypen;
with KartenRecords;

private with KartenressourcenDatentypen;

with LeseWeltkarteneinstellungen;

package KartengeneratorUnterwasserressourcenLogik is
   pragma Elaborate_Body;
   use type KartenDatentypen.SenkrechteBasis;
   use type KartenDatentypen.WaagerechteBasis;

   procedure KartengeneratorUnterwasserressourcen
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord)
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

private

   WelcheRessource : KartenressourcenDatentypen.Ressourcen_Enum;

   GezogeneZahl : SystemDatentypenHTSEB.NullBisHundert;
   Zahlenspeicher : SystemDatentypenHTSEB.NullBisHundert;



   function RessourceZusatzberechnungen
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      RessourceExtern : in KartenressourcenDatentypen.Ressourcen_Unterfläche_Wasser_Enum)
      return KartenressourcenDatentypen.Ressourcen_Enum
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

   function ZusatzberechnungFisch
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      RessourceExtern : in KartenressourcenDatentypen.Ressourcen_Enum)
      return KartenressourcenDatentypen.Ressourcen_Enum
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

   function ZusatzberechnungWal
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      RessourceExtern : in KartenressourcenDatentypen.Ressourcen_Enum)
      return KartenressourcenDatentypen.Ressourcen_Enum
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

   function ZusatzberechnungHochwertigesHolz
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      RessourceExtern : in KartenressourcenDatentypen.Ressourcen_Enum)
      return KartenressourcenDatentypen.Ressourcen_Enum
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

end KartengeneratorUnterwasserressourcenLogik;
