({
	init : function(component, event, helper) {
		helper.reset(component, helper);

		var completionSteps = [
			{
				isComplete: false,
				errorMsg: '',
				completionDate: "-",
				title: "Assign current user to PermissionSet",
				descr: "",
				reasoning: "All access is granted by permission sets. See PermissionSet: Demo Quick Action for more.",
				seeMore: "a02L000000Aj82IIAR",
				seeMoreLabel: "Example Record"
			},
			{
				isComplete: true,
				completionDate: "now",
				title: "Assign current user to PermissionSet",
				descr: "You were assigned to SomePermissionSet"
			},
			{
				isComplete: true,
				errMsg: "Could not assign permission set",
				completionDate: "now",
				title: "Assign current user to PermissionSet",
				descr: "You were assigned to SomePermissionSet"
			}
		];
		component.set("v.completionSteps", completionSteps);
	},

	/**
	 * Handle when the setup button is clicked
	 */
	handleSetupClicked : function(component, event, helper){
		console.info('setup was clicked');
	}
})