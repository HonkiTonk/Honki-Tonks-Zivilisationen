private with KartengrundDatentypen;

package KartenDatenbankeneditorLogik is
   pragma Elaborate_Body;

   procedure KartenDatenbankenEditor;

private

   Feldauswahl : KartengrundDatentypen.Kartengrund_Enum;
   AktuelleAuswahl : KartengrundDatentypen.Kartengrund_Enum;

   procedure Feldeinstellungen
     (FeldExtern : in KartengrundDatentypen.Kartengrund_Vorhanden_Enum);



   function Kartenfeldauswahl
     return KartengrundDatentypen.Kartengrund_Enum;

end KartenDatenbankeneditorLogik;
