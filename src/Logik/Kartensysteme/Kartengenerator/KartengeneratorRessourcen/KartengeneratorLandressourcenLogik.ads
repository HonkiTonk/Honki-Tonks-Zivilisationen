private with SystemDatentypenHTSEB;

with KartenDatentypen;
with KartenRecords;

private with KartenextraDatentypen;

with LeseWeltkarteneinstellungen;

package KartengeneratorLandressourcenLogik is
   pragma Elaborate_Body;
   use type KartenDatentypen.Senkrechte;
   use type KartenDatentypen.Waagerechte;

   procedure KartengeneratorLandressourcen
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord)
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

private

   WelcheRessource : KartenextraDatentypen.Ressourcen_Enum;

   GezogeneZahl : SystemDatentypenHTSEB.NullBisHundert;
   Zahlenspeicher : SystemDatentypenHTSEB.NullBisHundert;



   function RessourceZusatzberechnungen
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      RessourceExtern : in KartenextraDatentypen.Ressourcen_Oberfläche_Land_Enum)
      return KartenextraDatentypen.Ressourcen_Enum
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

   function ZusatzberechnungKohle
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      RessourceExtern : in KartenextraDatentypen.Ressourcen_Oberfläche_Land_Enum)
      return KartenextraDatentypen.Ressourcen_Enum
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

   function ZusatzberechnungEisen
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      RessourceExtern : in KartenextraDatentypen.Ressourcen_Oberfläche_Land_Enum)
      return KartenextraDatentypen.Ressourcen_Enum
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

   function ZusatzberechnungÖl
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      RessourceExtern : in KartenextraDatentypen.Ressourcen_Oberfläche_Land_Enum)
      return KartenextraDatentypen.Ressourcen_Enum
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

   function ZusatzberechnungHochwertigerBoden
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      RessourceExtern : in KartenextraDatentypen.Ressourcen_Oberfläche_Land_Enum)
      return KartenextraDatentypen.Ressourcen_Enum
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

   function ZusatzberechnungHochwertigesHolz
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      RessourceExtern : in KartenextraDatentypen.Ressourcen_Oberfläche_Land_Enum)
      return KartenextraDatentypen.Ressourcen_Enum
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

   function ZusatzberechnungGold
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      RessourceExtern : in KartenextraDatentypen.Ressourcen_Oberfläche_Land_Enum)
      return KartenextraDatentypen.Ressourcen_Enum
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

end KartengeneratorLandressourcenLogik;
