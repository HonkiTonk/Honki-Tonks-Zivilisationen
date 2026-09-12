private with KartenzusatzgrundDatentypen;

package KartenDatenbankeneditorLogik is
   pragma Elaborate_Body;

   procedure KartenDatenbankenEditor;

private

   Feldauswahl : KartenzusatzgrundDatentypen.Kartengrund_Enum;
   AktuelleAuswahl : KartenzusatzgrundDatentypen.Kartengrund_Enum;

   procedure Feldeinstellungen
     (FeldExtern : in KartenzusatzgrundDatentypen.Kartengrund_Vorhanden_Enum);



   function Kartenfeldauswahl
     return KartenzusatzgrundDatentypen.Kartengrund_Enum;

end KartenDatenbankeneditorLogik;
