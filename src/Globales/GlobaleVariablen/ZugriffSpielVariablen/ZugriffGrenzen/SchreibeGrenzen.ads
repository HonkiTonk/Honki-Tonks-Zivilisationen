with SpeziesDatentypen;
with StadtDatentypen;
with EinheitenDatentypen;
with ZahlenDatentypen;
with ProduktionDatentypen;
with SpielRecords;

package SchreibeGrenzen is
   pragma Elaborate_Body;

   procedure Städtegrenzen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      StädtegrenzeExtern : in StadtDatentypen.Städtebereich);
   pragma Inline (Städtegrenzen);
   
   procedure Einheitengrenze
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      EinheitengrenzeExtern : in EinheitenDatentypen.EinheitenbereichVorhanden);
   pragma Inline (Einheitengrenze);
   
   procedure Geldgrenze
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      GeldgrenzeExtern : in ZahlenDatentypen.EigenesNatural);
   pragma Inline (Geldgrenze);
   
   procedure Forschungsgrenze
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      ForschungsgrenzeExtern : in ProduktionDatentypen.Lagermenge);
   pragma Inline (Forschungsgrenze);
   
   procedure Geldgewinngrenze
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      GeldgewinngrenzeExtern : in ProduktionDatentypen.Lagermenge);
   pragma Inline (Geldgewinngrenze);
   
   procedure Forschungsgewinngrenze
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      ForschungsgewinngrenzeExtern : in ProduktionDatentypen.Lagermenge);
   pragma Inline (Forschungsgewinngrenze);
   
   procedure Speziesrundengrenze
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      SpeziesrundengrenzeExtern : in ZahlenDatentypen.EigenesNatural);
   pragma Inline (Speziesrundengrenze);
   
   procedure GanzerEintrag
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      EintragExtern : in SpielRecords.GrenzenRecord);
   pragma Inline (GanzerEintrag);

end SchreibeGrenzen;
